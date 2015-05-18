//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {

    var businesses: [Business]!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var searchView : UISearchBar!
    
    var lastSearchTerm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        let frameWidth = self.tableView.frame.width
        self.searchView = UISearchBar(frame: CGRectMake(-5.0, 0.0, frameWidth, 50))
        self.searchView.delegate = self
        self.searchView.placeholder = "Search"
        self.navigationItem.titleView = searchView
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.76, green: 0.07, blue: 0, alpha: 0)
        
        // hide the table view before search
        self.tableView.hidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("text changed to \(searchText)")
        lastSearchTerm = searchText
        
        if (lastSearchTerm == "") {
            self.errorMessageLabel.text = "Search Yelp!"
            self.tableView.hidden = true
            self.errorMessageLabel.hidden = false
        } else {
            self.tableView.hidden = false
            self.errorMessageLabel.hidden = true
            searchYelp(lastSearchTerm)
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = self.businesses {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
        
    }
    
    func searchYelp(searchTerm : String) {
        var sortMode = YelpSortMode.BestMatched
        Business.searchWithTerm(searchTerm, sort: sortMode, categories: [], deals: false, radius: nil) { (businesses: [Business]!, error: NSError!) -> Void in
            if businesses != nil && self.lastSearchTerm == searchTerm {
                self.showTableIfResultsNonEmpty(businesses!.count)
                self.businesses = businesses
                self.tableView.reloadData()
                for business in businesses {
                    println(business.name!)
                    println(business.address!)
                }
            }
        }
    }
    
    func showTableIfResultsNonEmpty(count : Int) {
        if (count == 0) {
            self.errorMessageLabel.text = "No results found."
            self.errorMessageLabel.hidden = false
            self.tableView.hidden = true
        } else {
            self.tableView.hidden = false
            self.errorMessageLabel.hidden = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController : FiltersViewController, didUpdateFilters filters : [String:AnyObject]) {
        
        var categories = filters["categories"] as! [String]
        var offeringADeal = filters["offering_a_deal"] as! Bool
        var radius = filters["radius"] as! Double
        var sortModeIndex = filters["sort_by"] as! Int
        var sortMode = YelpSortMode(rawValue: sortModeIndex)
        
        Business.searchWithTerm(lastSearchTerm, sort: sortMode, categories: categories, deals: offeringADeal, radius: radius) {
            (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }

}
