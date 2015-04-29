//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by David Lundgren on 4/23/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    let searchBar = UISearchBar()
    var searchTerm = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        navigationItem.titleView = searchBar
        
        Business.searchWithTerm(searchTerm, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchTerm = searchBar.text
        Business.searchWithTerm(searchTerm, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        })
    }
    
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        println(filters)
        var categories = filters["categories"] as? [String]
        let deals = filters["deals"] as! Bool
        let sortType = YelpSortMode(rawValue: filters["sortType"] as! Int)!
        Business.searchWithTerm(searchTerm, sort: sortType, categories: categories, deals: deals) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    
}
