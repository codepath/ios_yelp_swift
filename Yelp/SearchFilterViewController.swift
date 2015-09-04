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

    
 
    var categories : Dictionary<String,[(String)]> = [
        "Afghan": ["afghani"],
        "African": ["african"],
        "American, new": ["newamerican"],
        "American, traditional": ["tradamerican"],
        "Arabian": ["arabian"],
        "Argentine": ["argentine"],
        "Armenian": ["armenian"],
        "Asian Fusion": ["asianfusion"],
        "Asturian": ["asturian"],
        "Australian": ["australian"],
        "Austrian": ["austrian"],
        "Baguettes": ["baguettes"],
        "Bangladeshi": ["bangladeshi"],
        "Barbeque": ["bbq"],
        "Basque": ["basque"],
        "Bavarian": ["bavarian"],
        "Beer Garden": ["beergarden"],
        "Beer Hall": ["beerhall"]
    ]
    
    var sortedCatNames : [String]?
    

    // I'm trying to use native multiple-selection support:
    // http://stackoverflow.com/questions/3040894/uitableview-multiple-selection
    // but perhaps allowsMultipleSelection is deprecated?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortedCatNames = (Array(self.categories.keys)).sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }

        
        self.tableFoodCategory.dataSource = self
        self.tableFoodCategory.delegate = self
        
        self.tableFoodCategory.allowsMultipleSelection = true
        
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
        cell.title.text = self.sortedCatNames![indexPath.row]
        
        return cell

    }
    
}
