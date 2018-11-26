//
//  UIImageView+Utilites.swift
//  NewsApp
//
//  Created by Jothiram Elangovan on 26/11/18.
//

import UIKit

public extension UIImageView {
    
    public func imageFromURl(_ urlString: String?, placeholderImage: UIImage) {
        guard let confirmedURLString = urlString,
            let confirmedURL = URL(string: confirmedURLString) else {
                self.image = placeholderImage
                return
        }
        APIManager.shared.getImageFromUrl(confirmedURL) { (image) in
            DispatchQueue.main.async {
                if let confirmedImage = image {
                    self.image = confirmedImage
                } else {
                    self.image = placeholderImage
                }
            }
        }
    }
}
