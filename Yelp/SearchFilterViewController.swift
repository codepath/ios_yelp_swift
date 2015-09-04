//
//  SearchFilterViewController.swift
//  Yelp
//
//  Created by David Sklar on 9/2/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//


import UIKit

class SearchFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sliderMaxDist: UISlider!
    @IBOutlet weak var boolShowOnlyDeals: UISwitch!
    @IBOutlet weak var tableFoodCategory: UITableView!

    var numViews = 0
 
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
    
    var sortedCatNames : [String]?
    
    @IBAction func Button_OK(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    
    @IBAction func Button_Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    

    // I'm using native multiple-selection support:
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numViews += 1
        print(numViews)
        
        sortedCatNames = (Array(self.categories.keys)).sorted { $0.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending }
        
        self.tableFoodCategory.dataSource = self
        self.tableFoodCategory.delegate = self
        
        self.tableFoodCategory.allowsMultipleSelection = true
        
        self.tableFoodCategory.rowHeight = UITableViewAutomaticDimension
        self.tableFoodCategory.estimatedRowHeight = 120
 
    }
    
    
    
    func tableView(tableFoodCategory: UITableView, willDisplayCell cell : UITableViewCell, indexPath: NSIndexPath) {
            // nothing needed here
    }

    
    
    func tableView(tableFoodCategory: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedCatNames!.count
    }
    
    
    func tableView(tableFoodCategory: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableFoodCategory.dequeueReusableCellWithIdentifier("CellFoodCategory") as! CategoryListCell
        //println("CELLFORROW")
        //println(indexPath.row)
        //println(Array(categories.keys)[indexPath.row])
        cell.title.text = self.sortedCatNames![indexPath.row]
        
        // Specify that the cell should be selected
        self.tableFoodCategory.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
        return cell

    }
    
}
