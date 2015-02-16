//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, options: SearchOptions!, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "ll": "37.78842,-122.40403"]
        if options != nil {
            if options.sort != nil {
                parameters["sort"] = String(options.sort!)
            }
            if options.categories != nil || !options.categories!.isEmpty {
                parameters["category_filter"] = ",".join(options.categories!)
            }
            if options.radius != nil {
                parameters["radius_filter"] = String(options.radius!)
            }
            if options.includeDeals != nil {
                parameters["deals_filter"] = options.includeDeals! ? "true" : "false"
            }
        }
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
}
