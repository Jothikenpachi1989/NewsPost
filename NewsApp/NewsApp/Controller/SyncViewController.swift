//
//  SyncViewController.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import UIKit

class SyncViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var delegate: NewsUpdateDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startSync()
        // Do any additional setup after loading the view.
    }
    
    func startSync() {
        activityIndicator.startAnimating()
        APIManager.shared.getNewsData { (data, response, error) in
            if let confirmedError = error {
                self.presentSimpleAlert("Server Error", message: confirmedError.localizedDescription)
            } else if let confirmedData = data {
                DataParser.shared.parseData(confirmedData, completionHandler: { (errorString) in
                    if let confirmedError = errorString {
                        self.presentSimpleAlert("Parse Error", message: confirmedError)
                    } else {
                        self.syncComplete()
                    }
                })
            }
        }
    }
    
    func presentSimpleAlert(_ title: String, message: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                self.syncComplete()
            }))
            self.present(controller, animated: true) {}
        }
    }
    
    func syncComplete() {
        DispatchQueue.main.async {
            self.delegate?.updateNewsDataSource()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
