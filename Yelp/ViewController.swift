//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var client: YelpClient!
    var businesses = [Business]()
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "EA0Ahz2sN-eLIik1qYi45A"
    let yelpConsumerSecret = "Y3R6PTlIJQJB9zU2RnIUB_OBqHQ"
    let yelpToken = "Jf-rvyKh3m4sKjs_yUK3W7Yc6J6dJl1c"
    let yelpTokenSecret = "yLbnl56G9pS691QXKeNg802EXP8"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "BusinessCell", bundle:nil), forCellReuseIdentifier: "BusinessCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.titleView = UISearchBar()
        
        performYelpSearch("Thai", options: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessCell
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    @IBAction func cancelToViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func applyFilters(segue:UIStoryboardSegue) {
        let controller = segue.sourceViewController as FiltersViewController
        let filterOptions = controller.filterOptions
        
        println(filterOptions)

        performYelpSearch("Thai", options: filterOptions)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func performYelpSearch(term: String, options: SearchOptions!) {
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)

        client.searchWithTerm(term, options: options, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            let dictionaries = response["businesses"] as [NSDictionary]
            
            self.businesses = Business.businessesWithDictionaries(dictionaries)
            
            self.tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
}
