//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var searchFilterSettings = BusinessSearchFilterSettings()
    var searchBar: UISearchBar!
    var businesses: [Business]!
    
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UISearchBar
        configureSearchBar()

        // UITableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // BusinessSearchFilterSettings
        searchBar.text = "Restaurants"
        searchBusinesses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.placeholder = "e.g. Chicken and Waffles"
        searchBar.autocorrectionType = .Default
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navController = segue.destinationViewController as! UINavigationController
        let filtersController = navController.topViewController as! FiltersTableViewController
        filtersController.filterSettings = self.searchFilterSettings
    }
    
    @IBAction func unwindToBusinessListViaCancel(sender: UIStoryboardSegue) {
        let sourceVC = sender.sourceViewController
        sourceVC.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindToBusinessListViaSearch(sender: UIStoryboardSegue) {
        let sourceVC = sender.sourceViewController as! FiltersTableViewController
        searchFilterSettings = sourceVC.filterSettingsFromTableData()
        sourceVC.dismissViewControllerAnimated(true, completion: nil)
        searchBusinesses()
    }
    

    // MARK: - API access
    
    private func searchBusinesses() {
        searchFilterSettings.searchTerm = searchBar.text
        let settings = searchFilterSettings
        Business.searchWithTerm(settings.searchTerm!, sort: settings.sort, categories: settings.categories, deals: settings.deals, distance: settings.distance, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses            
            self.tableView.reloadData()

            /*
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
            */
        })
    }

}


// MARK: - UITableViewDataSource

extension BusinessesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let source = businesses {
            return source.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let business = businesses[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = business
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension BusinessesViewController: UITableViewDelegate {
    
}


// MARK: - UISearchBarDelegate

extension BusinessesViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBusinesses()
        searchBar.resignFirstResponder()
    }
}





