//
//  SearchOptions.swift
//  Yelp
//
//  Created by Joseph Ku on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class SearchOptions {
    var categories: [String]?
    var sort: Int?
    var radius: Int?
    var includeDeals: Bool?
    
    init(categories: [String]?, sort: Int?, radius: Int?, includeDeals: Bool?) {
        self.categories = categories
        self.sort = sort
        self.radius = radius
        self.includeDeals = includeDeals
    }
}
