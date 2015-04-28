//
//  BusinessCell.swift
//  Yelp
//
//  Created by Jose Hernandez on 4/27/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dolarLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        didSet {
            thumbImageView.setImageWithURL(business.imageURL)
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            ratingImageView.setImageWithURL(business.ratingImageURL)
            ratingLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
