//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Joseph Ku on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit


class FiltersViewController: UITableViewController {
    @IBOutlet weak var categoriesField: UITextField!
    @IBOutlet weak var dealsSwitch: UISwitch!
    @IBOutlet weak var radiusField: UITextField!
    
    let pickerValueArray = ["Best Matched", "Distance", "Highest Rated"]
    var filterOptions: SearchOptions!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ApplyFilters" {
            let categories = categoriesField.text.componentsSeparatedByString(",")
// I couldn't get the row selection to work. The row returned is always nil.
//            let row = self.tableView.indexPathForSelectedRow()
//            println(row!.section)
//            println(row!.row)
            let radius = radiusField.text.toInt()
            let includeDeals = dealsSwitch.on
            
            println(categories)
            println(radius)
            println(includeDeals)
            
            filterOptions = SearchOptions(categories: categories, sort: 1, radius: radius, includeDeals: includeDeals)
        }
    }
}
