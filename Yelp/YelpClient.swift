//
//  YelpClient.swift
//  Yelp
//
//  Created by Tejen Patel on 6/26/18.
//  Copyright (c) 2018 CodePath. All rights reserved.
//

import UIKit

import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: https://www.yelp.com/developers/v3/manage_app
let yelpAPIKey = "izCFqEx0usiPwAiv_ymJ4Sl2Lr_mpnN6U_VeEkn1iUyEUWLM2Rd76A6NlswCI-HlYVWYT2WYRFtNnD04lgageyBKPJkqDDA75C8UsJYwc7oXWMGDFSCRU93zoTBaW3Yx"

enum YelpSortMode: String {
    case best_match, rating, review_count, distance
}

class YelpClient: AFHTTPRequestOperationManager {
    var apiKey: String!
    
    //MARK: Shared Instance
    
    static let sharedInstance = YelpClient(yelpAPIKey: yelpAPIKey)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(yelpAPIKey: String) {
        self.apiKey = yelpAPIKey
        
        let baseUrl = URL(string: "https://api.yelp.com/v3/")
        super.init(baseURL: baseUrl)
        requestSerializer.setValue("Bearer \(self.apiKey!)", forHTTPHeaderField: "Authorization")
    }
    
    func searchWithTerm(_ term: String, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        return searchWithTerm(term, sort: nil, categories: nil, openNow: nil, completion: completion)
    }
    
    func searchWithTerm(_ term: String, sort: YelpSortMode?, categories: [String]?, openNow: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see https://www.yelp.com/developers/documentation/v3/business_search
        
        // Default the location to San Francisco
        var parameters: [String : AnyObject] = ["term": term as AnyObject, "location": "37.785771,-122.406165" as AnyObject]
        
        if sort != nil {
            parameters["sort_by"] = sort!.rawValue as AnyObject?
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["categories"] = (categories!).joined(separator: ",") as AnyObject?
        }
        
        if openNow != nil {
            parameters["open_now"] = openNow! as AnyObject
        }
        
        print(parameters)
        
        return self.get("businesses/search", parameters: parameters,
                        success: { (operation: AFHTTPRequestOperation, response: Any) -> Void in
                            if let response = response as? [String: Any]{
                                let dictionaries = response["businesses"] as? [NSDictionary]
                                if dictionaries != nil {
                                    completion(Business.businesses(array: dictionaries!), nil)
                                }
                            }
                        },
                        failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                            completion(nil, error)
                        })!
    }
}
