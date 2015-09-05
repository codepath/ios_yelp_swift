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
    
    var doneHandler : ((FilterState) -> Void)?
    
    var numViews = 0
    
    var state = FilterState()
    
    var sortedCatNames : [String]?
    
    @IBAction func Button_OK(sender: AnyObject) {
        // Propagate the latest category DB back to the parent VC to make persistent
        // the changes.
        if let cb = self.doneHandler {
            cb(self.state)
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
        
        if let categories = self.state.categories {
            sortedCatNames = (Array(categories.keys)).sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
            
            self.tableFoodCategory.dataSource = self
            self.tableFoodCategory.delegate = self
            
            // Important: I'm taking advantage of native mult-sel support:
            self.tableFoodCategory.allowsMultipleSelection = true
            
            self.tableFoodCategory.rowHeight = 30
        }
        
    }
    
    
    
    func tableView(tableFoodCategory: UITableView, willDisplayCell cell : UITableViewCell, indexPath: NSIndexPath) {
        // nothing needed here
    }
    
    
    
    // DID SELECT ROW
    func tableView(tableFoodCategory: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let catname : String = self.sortedCatNames?[indexPath.row] {
            // Persistently record the selection
            self.categories?[catname]?.append("selected")
            self.tableFoodCategory.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    
    // DID DESELECT ROW
    func tableView(tableFoodCategory: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let catname : String = self.sortedCatNames?[indexPath.row] {
            // Persistently record the selection
            self.categories?[catname]?.removeAtIndex(1)
            self.tableFoodCategory.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    
    
    
    // INQUIRE NUMBER OF ROWS IN TABLE
    func tableView(tableFoodCategory: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedCatNames!.count
    }
    
    
    // CONSTRUCT CELL AT ROW #(indexPath)
    func tableView(tableFoodCategory: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableFoodCategory.dequeueReusableCellWithIdentifier("CellFoodCategory") as! CategoryListCell
        
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        if let catname : String = self.sortedCatNames?[indexPath.row] {
            cell.title.text = catname
            
            // This cell should show the selected appearance
            if let valueLen = (self.categories?[catname]?.count) {
                if valueLen > 1 {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    self.tableFoodCategory.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
                }
            }
        }
        return cell
    }
    
    
    
    
    
    
}
