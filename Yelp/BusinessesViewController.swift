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
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listingTable.dataSource = self
        self.listingTable.delegate = self
        
        self.listingTable.rowHeight = 85 //UITableViewAutomaticDimension
        //self.listingTable.estimatedRowHeight = 120
        
        self.navigationItem.titleView = self.searchBar
        
        searchBar.delegate = self
        
        runOrRerunSearch("restaurant")
        
    }
    
    
    
    func runOrRerunSearch(term : String) {

//        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            
//            for business in businesses {
//                println(business.name!)
//                println(business.address!)
//            }
//        })
        

        // self.state has:  selectionStatus, maxDistance, boolLookOnlyForDeals, 
        Business.searchWithTerm(term, sort: self.state.sortMode, categories: self.state.getSetOfDesiredCategories(),
            deals: self.state.boolLookOnlyForDeals) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                println(business.name!)
                println(business.address!)
            }
            
            self.listingTable.reloadData()
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
            self.runOrRerunSearch("restaurant")
        } else {
            self.runOrRerunSearch(searchText)
        }
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
            }
        }
    }

}
