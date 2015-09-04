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

    var numViews = 0
    
    var categories : Dictionary<String,[String]>?
    
    var sortedCatNames : [String]?
    
    @IBAction func Button_OK(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    @IBAction func Button_Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    

    // I'm using native multiple-selection support:
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numViews += 1
        print(numViews)
        
        if let categories = self.categories {
            sortedCatNames = (Array(categories.keys)).sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
            
            self.tableFoodCategory.dataSource = self
            self.tableFoodCategory.delegate = self
            
            self.tableFoodCategory.allowsMultipleSelection = true
            
            self.tableFoodCategory.rowHeight = UITableViewAutomaticDimension
            self.tableFoodCategory.estimatedRowHeight = 120
        }
 
    }
    
    
    
    func tableView(tableFoodCategory: UITableView, willDisplayCell cell : UITableViewCell, indexPath: NSIndexPath) {
            // nothing needed here
    }

    
    
    func tableView(tableFoodCategory: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedCatNames!.count
    }
    
    
    func tableView(tableFoodCategory: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableFoodCategory.dequeueReusableCellWithIdentifier("CellFoodCategory") as! CategoryListCell
        //println("CELLFORROW")
        //println(indexPath.row)
        //println(Array(categories.keys)[indexPath.row])
        cell.title.text = self.sortedCatNames![indexPath.row]
        
        // Specify that the cell should be selected
        self.tableFoodCategory.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
        return cell

    }
    
}
