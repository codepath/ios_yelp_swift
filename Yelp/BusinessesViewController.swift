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
        
        self.listingTable.rowHeight = UITableViewAutomaticDimension
        self.listingTable.estimatedRowHeight = 120
        
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
        
        
        Business.searchWithTerm(term, sort: .Distance, categories: nil,
            deals: nil) { (businesses: [Business]!, error: NSError!) -> Void in
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
        let cell = self.listingTable.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessListingCell
        println("CELLFORROW")
        println(indexPath.row)
        cell.NameBusiness.text = self.businesses[indexPath.row].name
        
        return cell
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navC =  segue.destinationViewController as! UINavigationController
        if let slaveVC = navC.viewControllers[0] as? SearchFilterViewController {
            slaveVC.state = state
            slaveVC.doneHandler = {(newDict: FilterState) -> Void in
                    self.state = newDict
            }
        }
    }

}
