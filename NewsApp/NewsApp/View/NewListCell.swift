//
//  NewListCell.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 24/11/18.
//

import UIKit

class NewListCell: UITableViewCell {

    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var newsByTitle: UILabel!
    @IBOutlet var newsDate: UILabel!
    @IBOutlet var newsImageContainer: UIView!
    @IBOutlet var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageContainer.layer.cornerRadius = newsImageView.bounds.height / 2
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
