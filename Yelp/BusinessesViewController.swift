//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    // Protocol for the value is:
    // > if unselected category, value is a 1-elem array
    // > if selected category, value has a 2nd element that is the string "selected"
    //
    var categories : Dictionary<String,[String]> = [
        "Afghan": ["afghani"],
        "African": ["african"],
        "American, new": ["newamerican"],
        "American, traditional": ["tradamerican"],
        "Arabian": ["arabian"],
        "Argentine": ["argentine"],
        "Armenian": ["armenian"],
        "Asian Fusion": ["asianfusion"],
        "Asturian": ["asturian"],
        "Australian": ["australian"],
        "Austrian": ["austrian"],
        "Baguettes": ["baguettes"],
        "Bangladeshi": ["bangladeshi"],
        "Barbeque": ["bbq"],
        "Basque": ["basque"],
        "Bavarian": ["bavarian"],
        "Beer Garden": ["beergarden"],
        "Beer Hall": ["beerhall"],
        "Beisl": ["beisl"],
        "Belgian": ["belgian"],
        "Bistros": ["bistros"],
        "Black Sea": ["blacksea"],
        "Brasseries": ["brasseries"],
        "Brazilian": ["brazilian"],
        "Breakfast & Brunch": ["breakfast_brunch"],
        "British": ["british"],
        "Buffets": ["buffets"],
        "Bulgarian": ["bulgarian"],
        "Burgers": ["burgers"],
        "Burmese": ["burmese"],
        "Cafes": ["cafes"],
        "Cafeteria": ["cafeteria"],
        "Cajun/Creole": ["cajun"],
        "Cambodian": ["cambodian"],
        "Canadian": ["New)"],
        "Canteen": ["canteen"],
        "Caribbean": ["caribbean"],
        "Catalan": ["catalan"],
        "Chech": ["chech"],
        "Cheesesteaks": ["cheesesteaks"],
        "Chicken Shop": ["chickenshop"],
        "Chicken Wings": ["chicken_wings"],
        "Chilean": ["chilean"],
        "Chinese": ["chinese"],
        "Comfort Food": ["comfortfood"],
        "Corsican": ["corsican"],
        "Creperies": ["creperies"],
        "Cuban": ["cuban"],
        "Curry Sausage": ["currysausage"],
        "Cypriot": ["cypriot"],
        "Czech": ["czech"],
        "Czech/Slovakian": ["czechslovakian"],
        "Danish": ["danish"],
        "Delis": ["delis"],
        "Diners": ["diners"],
        "Dumplings": ["dumplings"],
        "Eastern European": ["eastern_european"],
        "Ethiopian": ["ethiopian"],
        "Fast Food": ["hotdogs"],
        "Filipino": ["filipino"],
        "Fish & Chips": ["fishnchips"],
        "Fondue": ["fondue"],
        "Food Court": ["food_court"],
        "Food Stands": ["foodstands"],
        "French Southwest": ["sud_ouest"],
        "French": ["french"],
        "Galician": ["galician"],
        "Gastropubs": ["gastropubs"],
        "Georgian": ["georgian"],
        "German": ["german"],
        "Giblets": ["giblets"],
        "Gluten-Free": ["gluten_free"],
        "Greek": ["greek"],
        "Halal": ["halal"],
        "Hawaiian": ["hawaiian"],
        "Heuriger": ["heuriger"],
        "Himalayan/Nepalese": ["himalayan"],
        "Hong Kong Style Cafe": ["hkcafe"],
        "Hot Dogs": ["hotdog"],
        "Hot Pot": ["hotpot"],
        "Hungarian": ["hungarian"],
        "Iberian": ["iberian"],
        "Indian": ["indpak"],
        "Indonesian": ["indonesian"],
        "International": ["international"],
        "Irish": ["irish"],
        "Island Pub": ["island_pub"],
        "Israeli": ["israeli"],
        "Italian": ["italian"],
        "Japanese": ["japanese"],
        "Jewish": ["jewish"],
        "Kebab": ["kebab"],
        "Korean": ["korean"],
        "Kosher": ["kosher"]
    ]
    
    
    @IBOutlet weak var listingTable: UITableView!
    
    var businesses: [Business]!
    
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
            slaveVC.categories = self.categories
            slaveVC.doneHandler = {(newDict: Dictionary<String,[String]>) -> Void in
                    self.categories = newDict
            }
        }
    }

}
