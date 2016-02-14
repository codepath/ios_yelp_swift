//
//  BusinessSearchFilterSettings.swift
//  Yelp
//
//  Created by Marcel Weekes on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

// TODO: not sure if we should use a class or a struct
// Model object to hold searchFilterSettings

class BusinessSearchFilterSettings {
    var distance: YelpDistanceFilter?
    var sort: YelpSortMode?
    var categories: [String]?
    var deals: Bool = false
    
    init() {
        distance = .Auto
        sort = .BestMatched
    }
}