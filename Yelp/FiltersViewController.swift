//
//  FiltersViewController.swift
//  Yelp
//
//  Created by David Lundgren on 4/27/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate, RadiusCellDelegate, SortCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    var radius = 1.0
    var deals = false
    var sortType = 0 // best
    var sectionTitles = ["Categories", "Deals", "Radius", "Sort"]
    
    weak var delegate: FiltersViewControllerDelegate?
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearch(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var filters = [String:AnyObject]()
        var selectedCategories = [String]()
        for (row, isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        
        filters["deals"] = deals
        filters["radius"] = radius
        filters["sortType"] = sortType
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = yelpCategories()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return categories!.count ?? 0
        default:
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func categoriesCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SwitchCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        cell.switchLabel.text = categories[indexPath.row]["name"]
        cell.delegate = self
        cell.cellType = "category"
        cell.onSwitch.on = switchStates[indexPath.row] ?? false
        return cell
    }
    
    func dealCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SwitchCell {
        let cell = categoriesCell(tableView, cellForRowAtIndexPath: indexPath)
        cell.switchLabel.text = "Deal or No Deal"
        cell.cellType = "deal"
        return cell
    }
    
    func radiusCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RadiusCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RadiusCell", forIndexPath: indexPath) as! RadiusCell
        cell.delegate = self
        return cell
    }
    
    func sortCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> SortCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SortCell", forIndexPath: indexPath) as! SortCell
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return categoriesCell(tableView, cellForRowAtIndexPath: indexPath)
        case 1:
            return dealCell(tableView, cellForRowAtIndexPath: indexPath)
        case 2:
            return radiusCell(tableView, cellForRowAtIndexPath: indexPath)
        default:
            return sortCell(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        if switchCell.cellType == "category" {
            switchStates[indexPath.row] = value
        } else {
            deals = value
        }
    }
    
    func radiusCell(radiusCell: RadiusCell, didChangeValue value: String) {
        radius = (radiusCell.radiusTextField.text as NSString).doubleValue
    }
    
    func sortCell(sortCell: SortCell, didChangeValue value: Int) {
        sortType = value
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func yelpCategories() -> [[String:String]] {
        return [
            ["name" : "Restaurants", "code":  "restaurants"],
            ["name" : "Bookstores", "code":  "bookstores"],
            ["name" : "Cafes", "code":  "coffee"],
        ]
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
