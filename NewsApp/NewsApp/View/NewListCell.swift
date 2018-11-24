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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
