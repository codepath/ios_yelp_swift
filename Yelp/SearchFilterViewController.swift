//
//  SearchFilterViewController.swift
//  Yelp
//
//  Created by David Sklar on 9/2/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//


import UIKit

class SearchFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sliderMaxDist: UISlider!
    @IBOutlet weak var boolShowOnlyDeals: UISwitch!
    @IBOutlet weak var tableFoodCategory: UITableView!

    
 
    var categories = [
        "Afghan": ["afghani"],
        "African": ["african"],
        "American, new": ["newamerican"],
        "American, traditional": ["tradamerican"],
        "Arabian": ["arabian"],
        "Argentine": ["argentine"]
    ]

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableFoodCategory.dataSource = self
        self.tableFoodCategory.delegate = self
        
        self.tableFoodCategory.rowHeight = UITableViewAutomaticDimension
        self.tableFoodCategory.estimatedRowHeight = 120
 
    }
    
    
    
    
    
    
    func tableView(tableFoodCategory: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(categories.keys).count
    }
    
    
    func tableView(tableFoodCategory: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableFoodCategory.dequeueReusableCellWithIdentifier("CellFoodCategory") as! CategoryListCell
        println("CELLFORROW")
        println(indexPath.row)
        println(Array(categories.keys)[indexPath.row])
        cell.title.text = Array(categories.keys)[indexPath.row] as String
        
        return cell

    }
    
}
