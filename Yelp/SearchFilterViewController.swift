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
    @IBOutlet weak var labelCurrentDistSelection: UILabel!
    @IBOutlet weak var chooserSortBy: UISegmentedControl!
    
    var doneHandler : ((FilterState) -> Void)?
    
    var state = FilterState()
    
    
    @IBAction func chooser_sorting_HandleValueChanged(sender: AnyObject) {
        if let chooser = sender as? UISegmentedControl {
            self.state.curSortModeIndex = chooser.selectedSegmentIndex
        }
        
    }
    
    @IBAction func Switch_Deal_HandleToggle(sender: AnyObject) {
        if let switcheroo = sender as? UISwitch {
            self.state.boolLookOnlyForDeals = switcheroo.on
        }
    }
    
    
    func updateDistFeedback() {
        let slider = sliderMaxDist
        labelCurrentDistSelection.text = (NSString(format: "%.1f", slider.value) as String) + " miles"
    }
    
    
    @IBAction func Slider_HandleValueChanged(sender: AnyObject) {
        if let slider = sender as? UISlider {
            self.state.maxDistance = slider.value
            self.updateDistFeedback()
        }
    }
    
    
    
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
        
        self.tableFoodCategory.dataSource = self
        self.tableFoodCategory.delegate = self
        
        // Important: I'm taking advantage of native mult-sel support:
        self.tableFoodCategory.allowsMultipleSelection = true
        self.tableFoodCategory.rowHeight = 30
        
        // Init the GUI controls to match the passed-in state
        self.sliderMaxDist.value = self.state.maxDistance
        self.boolShowOnlyDeals.setOn(self.state.boolLookOnlyForDeals, animated:false)
        self.chooserSortBy.selectedSegmentIndex = self.state.curSortModeIndex
        self.updateDistFeedback()
    }
    
    
    
    func tableView(tableFoodCategory: UITableView, willDisplayCell cell : UITableViewCell, indexPath: NSIndexPath) {
        // nothing needed here
    }
    
    
    
    // DID SELECT ROW
    func tableView(tableFoodCategory: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Persistently record the selection
        self.state.selectionStatus[indexPath.row] = true
        self.tableFoodCategory.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    // DID DESELECT ROW
    func tableView(tableFoodCategory: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // Persistently record the selection
        self.state.selectionStatus[indexPath.row] = false
        self.tableFoodCategory.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    
    
    
    // INQUIRE NUMBER OF ROWS IN TABLE
    func tableView(tableFoodCategory: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.state.arrayCategories.count
    }
    
    
    // CONSTRUCT CELL AT ROW #(indexPath)
    func tableView(tableFoodCategory: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableFoodCategory.dequeueReusableCellWithIdentifier("CellFoodCategory") as! CategoryListCell
        
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        let catdetails = self.state.arrayCategories[indexPath.row]
        cell.title.text = catdetails[1]
        
        // This cell should show the selected appearance
        if self.state.selectionStatus[indexPath.row] {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            self.tableFoodCategory.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            
        }
        
        return cell
    }
    
    
}
