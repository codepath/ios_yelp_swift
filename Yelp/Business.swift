//
//  Business.swift
//  Yelp
//
//  Created by Joseph Ku on 2/13/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class Business: NSObject {
    let METER_TO_MILES = 0.000621371
    
    var name: String!
    var imageUrl: String!
    var ratingImageUrl: String!
    var numReviews: Int!
    var address: String!
    var categories: [String]!
    var distance: Double!

    init(dictionary: NSDictionary) {
        println(dictionary)
        
        self.name = dictionary["name"] as String
        self.imageUrl = dictionary["image_url"] as String
        self.ratingImageUrl = dictionary["rating_img_url"] as String
        self.numReviews = dictionary["review_count"] as Int
        let location = dictionary["location"] as NSDictionary
        let displayAddress = location["display_address"] as [String]
        self.address = "\(displayAddress[0]), \(displayAddress[1])"
        let categoriesArray: [[String]] = dictionary["categories"] as [[String]]
        self.categories = categoriesArray.map({$0[0]})
        let meters = dictionary["distance"] as Double
        self.distance = meters * METER_TO_MILES
    }
    
    class func businessesWithDictionaries(dictionaries: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        
        for dictionary in dictionaries {
            var business = Business(dictionary: dictionary)
            
            businesses.append(business)
        }
        
        return businesses
    }
}
