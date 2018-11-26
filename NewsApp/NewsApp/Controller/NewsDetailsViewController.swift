 //
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet var newsDetailHeader: UILabel!
    @IBOutlet var newsDetailImage: UIImageView!
    @IBOutlet var newsImageLoader: UIActivityIndicatorView!
    @IBOutlet var newsImageCaption: UILabel!
    @IBOutlet var newsDetailAbstract: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsDetailHeader.text = nil
        newsDetailImage.image = nil
        newsImageCaption.text = nil
        newsDetailAbstract.text = nil
        newsDetailImage.layer.shadowColor = UIColor.black.cgColor
        self.updateView()
        // Do any additional setup after loading the view.
    }
    
    var detailItem: NewsList? {
        didSet {
            
        }
    }
    
    func updateView() {
        guard let confirmedDetailItem = detailItem else {
            return
        }
        newsDetailHeader.text = confirmedDetailItem.title
        newsImageCaption.text = confirmedDetailItem.imageCaption
        newsDetailAbstract.text = confirmedDetailItem.abstract
        newsDetailImage.imageFromURl(confirmedDetailItem.imageUrl, placeholderImage: UIImage(named: "default-image.png")!)
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
