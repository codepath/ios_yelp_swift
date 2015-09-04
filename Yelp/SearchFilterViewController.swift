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
    
    var doneHandler: ((Dictionary<String,[String]>) -> Void)?

    var numViews = 0
    
    var categories : Dictionary<String,[String]>?
    
    var sortedCatNames : [String]?
    
    @IBAction func Button_OK(sender: AnyObject) {
        // Propagate the latest category DB back to the parent VC to make persistent
        // the changes.
        if let cb = self.doneHandler {
            cb(self.categories!)
        }
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    @IBAction func Button_Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numViews += 1
        print(numViews)
        
        if let categories = self.categories {
            sortedCatNames = (Array(categories.keys)).sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
            
            self.tableFoodCategory.dataSource = self
            self.tableFoodCategory.delegate = self
            
            // Important: I'm taking advantage of native mult-sel support:
            self.tableFoodCategory.allowsMultipleSelection = true
            
            self.tableFoodCategory.rowHeight = UITableViewAutomaticDimension
            self.tableFoodCategory.estimatedRowHeight = 120
        }
 
    }
    
    
    
    func tableView(tableFoodCategory: UITableView, willDisplayCell cell : UITableViewCell, indexPath: NSIndexPath) {
            // nothing needed here
    }


    
    // DID SELECT ROW
    func tableView(tableFoodCategory: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let catname : String = self.sortedCatNames?[indexPath.row] {
            
            // Specify that the cell should be selected
            self.categories?[catname]?.append("selected")
        }
    }

    
    
    // numberOfRowsInSection
    func tableView(tableFoodCategory: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedCatNames!.count
    }
    
    
    func tableView(tableFoodCategory: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableFoodCategory.dequeueReusableCellWithIdentifier("CellFoodCategory") as! CategoryListCell

        if let catname : String = self.sortedCatNames?[indexPath.row] {
            cell.title.text = catname
        
            // Specify that the cell should be selected
            if let valueLen = (self.categories?[catname]?.count) {
                if valueLen > 1 {
                    self.tableFoodCategory.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
                }
            }
        }
        return cell
    }
    
    
    
    
    
    
}
