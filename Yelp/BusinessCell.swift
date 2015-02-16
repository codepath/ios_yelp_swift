//
//  BusinessCell.swift
//  Yelp
//
//  Created by Joseph Ku on 2/13/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business! {
        get {
            return self.business
        }
        set(business) {
            self.thumbImageView.setImageWithURL(NSURL(string: business.imageUrl))
            self.nameLabel.text = business.name
            self.distanceLabel.text = NSString(format: "%0.2f mi", business.distance)
            self.ratingImageView.setImageWithURL(NSURL(string: business.ratingImageUrl))
            self.reviewsLabel.text = NSString(format: "%d Reviews", business.numReviews)
            self.addressLabel.text = business.address
            self.categoriesLabel.text = ", ".join(business.categories)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.thumbImageView.layer.cornerRadius = 3
        self.thumbImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
