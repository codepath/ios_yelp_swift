//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var listingTable: UITableView!
    
    var businesses: [Business]!
    
    var state = FilterState()
    
    let defaultSearchTerm = "restaurant"
    var currentSearchTerm : String
    var boolSearchInProgress = false
    var boolSearchTermAwaitingProcessing = true
    
    let searchBar = UISearchBar()
    
    
    required init(coder aDecoder: NSCoder) {
        currentSearchTerm = defaultSearchTerm
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listingTable.dataSource = self
        self.listingTable.delegate = self
        
        self.listingTable.rowHeight = 75
        
        self.navigationItem.titleView = self.searchBar
        
        searchBar.delegate = self
        
        var swfcfg : SwiftLoader.Config = SwiftLoader.Config()
        swfcfg.backgroundColor = UIColor.blueColor()
        swfcfg.spinnerColor = UIColor.whiteColor()
        SwiftLoader.setConfig(swfcfg)
        
        runOrRerunSearch()
        
    }
    
    
    
    func runOrRerunSearch() {
        
        if (self.boolSearchTermAwaitingProcessing && !self.boolSearchInProgress) {
            self.boolSearchInProgress = true
            self.boolSearchTermAwaitingProcessing = false
            SwiftLoader.show(animated: false)
            Business.searchWithTerm(self.currentSearchTerm, sort: self.state.sortModes_Ordering[self.state.curSortModeIndex], categories: self.state.getSetOfDesiredCategories(),
                deals: self.state.boolLookOnlyForDeals, maxRadius: self.state.maxDistance) { (businesses: [Business]!, error: NSError!) -> Void in
                    SwiftLoader.hide()
                    self.businesses = businesses
                    self.listingTable.reloadData()
                    self.boolSearchInProgress = false
                    if self.boolSearchTermAwaitingProcessing {
                        // Hey - a change in the current search term came in from the user
                        // while we were awaiting the completion of this async query.
                        // It's time to launch another search.
                        self.runOrRerunSearch()
                    }
            }
        }
        
    }
    
    
    
    
    var searchActive : Bool = false
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            self.currentSearchTerm = defaultSearchTerm
        } else {
            self.currentSearchTerm = searchText
        }
        self.boolSearchTermAwaitingProcessing = true
        self.runOrRerunSearch()
    }
    
    
    
    
    func tableView(listingTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("COUNT")
        if let theList = self.businesses {
            println(theList.count)
            return theList.count
        } else {
            return 0
        }
    }
    
    
    func tableView(listingTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let details = self.businesses[indexPath.row]
        let cell = self.listingTable.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessListingCell
        //println("CELLFORROW")
        //println(indexPath.row)
        cell.NameBusiness.text = details.name
        cell.imageviewBusiness.setImageWithURL(details.imageURL)
        cell.imageviewRating.setImageWithURL(details.ratingImageURL)
        cell.labelDistanceAddress.text = details.distance! + ", " + details.address!
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navC =  segue.destinationViewController as! UINavigationController
        if let slaveVC = navC.viewControllers[0] as? SearchFilterViewController {
            slaveVC.state.initFromOther(self.state)
            slaveVC.doneHandler = {(newDict: FilterState) -> Void in
                self.state = newDict
                self.runOrRerunSearch()
            }
        }
    }
    
}
