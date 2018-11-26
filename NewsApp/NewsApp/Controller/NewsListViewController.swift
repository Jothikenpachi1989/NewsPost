//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import UIKit

protocol NewsUpdateDelegate {
    func updateNewsDataSource()
}

class NewsListViewController: UITableViewController, UISearchBarDelegate, NewsUpdateDelegate {
    
    var detailViewController: NewsDetailsViewController? = nil
    var filteredDataSource = [NewsList]()
    let activityIndicator = UIRefreshControl()
    let appDelgate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? NewsDetailsViewController
        }
        
        addRefreshControl()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !appDelgate.isInitialDSyncStarted {
            self.presentSyncController()
        }
    }
    
    func addRefreshControl() {
        tableView.refreshControl = activityIndicator
        activityIndicator.tintColor = UIColor.black
        activityIndicator.attributedTitle = NSAttributedString(string: "Fetching News Data ...", attributes: nil)
        activityIndicator.addTarget(self, action: #selector(refreshNewsData), for: .valueChanged)
    }

    // MARK: - Searchbar Delegate
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDataSource.removeAll()
        if searchText.isEmpty {
            filteredDataSource.append(contentsOf: DataParser.shared.dataSource)
        } else {
            filteredDataSource.append(contentsOf: DataParser.shared.dataSource.filter { $0.title.contains(searchText) })
        }
        
        defer {
            tableView.reloadData()
        }
    }
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let newsObject = filteredDataSource[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! NewsDetailsViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.detailItem = newsObject
            }
        } else if segue.identifier == "syncSegue" {
            if let confirmedSyncController = segue.destination as? SyncViewController {
                appDelgate.isInitialDSyncStarted = true
                confirmedSyncController.delegate = self
            }
        }
    }
    
    @objc func refreshNewsData() {
        APIManager.shared.getNewsData { (data, response, error) in
            if let confirmedError = error {
                self.presentSimpleAlert("Server Error", message: confirmedError.localizedDescription)
            } else if let confirmedData = data {
                DataParser.shared.parseData(confirmedData, completionHandler: { (errorString) in
                    if let confirmedError = errorString {
                        self.presentSimpleAlert("Parse Error", message: confirmedError)
                    } else {
                        self.updateDataSource()
                    }
                })
            }
        }
    }
    
    func presentSimpleAlert(_ title: String, message: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                self.tableView.refreshControl?.endRefreshing()
            }))
            self.present(controller, animated: true) {}
        }
    }
    
    func updateDataSource() {
        filteredDataSource.removeAll()
        filteredDataSource.append(contentsOf: DataParser.shared.dataSource)
        DispatchQueue.main.async {
            self.activityIndicator.endRefreshing()
            self.tableView.reloadData()
        }
    }

    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewListCell
        let newsObject = filteredDataSource[indexPath.row]
        cell.newsTitle?.text = newsObject.title
        cell.newsByTitle?.text = newsObject.byLine
        cell.newsDate.text = newsObject.publishingDateString
        cell.newsImageView.imageFromURl(newsObject.imageUrl, placeholderImage: UIImage(named: "default-image.png")!)
        return cell
    }
    
    // MARK: - News update datasource
    
    func updateNewsDataSource() {
        self.updateDataSource()
    }
    
    // MARK: - present Sync controller
    
    func presentSyncController() {
        self.performSegue(withIdentifier: "syncSegue", sender: self)
    }
    
}
