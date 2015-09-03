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
    
    let searchEntry = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listingTable.dataSource = self
        self.listingTable.delegate = self
        
        self.listingTable.rowHeight = UITableViewAutomaticDimension
        self.listingTable.estimatedRowHeight = 120
        
        self.navigationItem.titleView = self.searchEntry
        
        searchEntry.delegate = self


//        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            
//            for business in businesses {
//                println(business.name!)
//                println(business.address!)
//            }
//        })
        
        
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                println(business.name!)
                println(business.address!)
            }
            
            self.listingTable.reloadData()
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
        
        // set cell's textLabel.text property
        // set cell's detailTextLabel.text property
        return cell
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
