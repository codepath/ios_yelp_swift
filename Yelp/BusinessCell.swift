//
//  BusinessCell.swift
//  Yelp
//
//  Created by Sunny Rochiramani on 5/17/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    var business : Business! {
        didSet {
            businessLabel.text = business.name
            businessImageView.setImageWithURL(business.imageURL)
            businessCategoryLabel.text = business.categories
            businessAddressLabel.text = business.address
            numberReviewsLabel.text = "\(business.reviewCount!) Reviews"
            businessRatingsImageView.setImageWithURL(business.ratingImageURL)
            businessDistanceLabel.text = business.distance
        }
    }

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var businessRatingsImageView: UIImageView!
    @IBOutlet weak var businessCategoryLabel: UILabel!
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var numberReviewsLabel: UILabel!
    @IBOutlet weak var businessDistanceLabel: UILabel!
    @IBOutlet weak var businessPriceIndicatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        businessImageView.layer.cornerRadius = 2
        businessImageView.clipsToBounds = true
        businessLabel.preferredMaxLayoutWidth = businessLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        businessLabel.preferredMaxLayoutWidth = businessLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
