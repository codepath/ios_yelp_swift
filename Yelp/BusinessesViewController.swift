//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var loadingAdditionalData = false
    
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
        
        if segue.identifier == "filtersSegue" {
            let navController = segue.destinationViewController as! UINavigationController
            let filtersController = navController.topViewController as! FiltersTableViewController
            filtersController.filterSettings = self.searchFilterSettings
        }
        
        if segue.identifier == "mapSegue" {
            let navController = segue.destinationViewController as! UINavigationController
            let mapController = navController.topViewController as! BusinessesMapViewController
            mapController.businesses = businesses
        }
        
        if segue.identifier == "detailsSegue" {
            let cell = sender as! BusinessCell
            let detailsController = segue.destinationViewController as! BusinessDetailViewController
            detailsController.business = cell.business
        }
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
        let settings = searchFilterSettings
        Business.searchWithTerm(searchBar.text!, settings: settings, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses            
            self.tableView.reloadData()
        })
    }
    
    private func loadAdditionalBusinesses() {
        let settings = searchFilterSettings

        let limit  = 10
        let offset = businesses.count
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.labelText = "Loading..."

        Business.searchWithTerm(searchBar.text!, settings: settings, limit: limit, offset: offset, completion: { (addlBusinesses: [Business]!, error: NSError!) -> Void in
            self.businesses.appendContentsOf(addlBusinesses)

            // all finished
            self.loadingAdditionalData = false
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            self.tableView.reloadData()
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


// MARK: - UISearchBarDelegate

extension BusinessesViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !loadingAdditionalData {
            
            // determine (dynamic) height of tableView and threshold for add'l data
            let scrollViewContentHeight = tableView.contentSize.height
            let dataRequestThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if scrollView.contentOffset.y > dataRequestThreshold && (tableView.dragging) {
                
                loadingAdditionalData = true
                loadAdditionalBusinesses()
            }
        }
    }
}




