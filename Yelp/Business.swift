//
//  Business.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class Business: NSObject {
    let name: String?
    let address: String?
    let imageURL: URL?
    let categories: String?
    let distance: String?
    let ratingImage: UIImage?
    let reviewCount: NSNumber?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        
        let imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            let addressArray = location!["display_address"] as? NSArray
            if addressArray != nil {
                if addressArray!.count > 0 {
                    address = addressArray![0] as! String
                }
                if addressArray!.count > 1 {
                    address += ", " + (addressArray![1] as! String)
                }
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [NSDictionary]
        if categoriesArray != nil {
            var categoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category["title"] as! String
                categoryNames.append(categoryName)
            }
            categories = categoryNames.joined(separator: ", ")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let rating = dictionary["rating"] as? Double
        if rating != nil {
            switch rating {
                case 1:
                    self.ratingImage = UIImage(named: "stars_1")
                    break
                case 1.5:
                    self.ratingImage = UIImage(named: "stars_1half")
                    break
                case 2:
                    self.ratingImage = UIImage(named: "stars_2")
                    break
                case 2.5:
                    self.ratingImage = UIImage(named: "stars_2half")
                    break
                case 3:
                    self.ratingImage = UIImage(named: "stars_3")
                    break
                case 3.5:
                    self.ratingImage = UIImage(named: "stars_3half")
                    break
                case 4:
                    self.ratingImage = UIImage(named: "stars_4")
                    break
                case 4.5:
                    self.ratingImage = UIImage(named: "stars_4half")
                    break
                case 5:
                    self.ratingImage = UIImage(named: "stars_5")
                    break
                default:
                    self.ratingImage = UIImage(named: "stars_0")
                    break
            }
        } else {
            self.ratingImage = UIImage(named: "stars_0")
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
    }
    
    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, completion: completion)
    }
    
    class func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, sort: sort, categories: categories, openNow: false, completion: completion)
    }
}
