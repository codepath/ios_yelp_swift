//
//  BusinessCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var ratingsImageView: UIImageView!
    @IBOutlet var reviewsCountLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var categoriesLabel: UILabel!

    
    var business: Business!{
        didSet{
            nameLabel.text = business.name
            thumbImageView.setImageWith(business.imageURL!)
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
            ratingsImageView.setImageWith(business.ratingImageURL!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
