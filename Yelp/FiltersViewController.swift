//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Sunny Rochiramani on 5/17/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController : FiltersViewController, didUpdateFilters filters : [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwiftCellDelegate {
    
    var offeringDealOn = false
    
    var distances : [[String : String]]!
    var distanceIndexSelected = 0
    var distancesExpanded = false
    
    var sortOptions : [String]!
    var sortOptionsIndexSelected = 0
    var sortOptionsExpanded = false
    
    var categories : [[String:String]]!
    var categoriesSwitchStates = [Int:Bool]()
    
    @IBOutlet weak var filtersTableView: UITableView!
    
    var delegate : FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.distances = getYelpDistanceOptions()
        self.sortOptions = getYelpSortByOptions()
        self.categories = getYelpCategories()
        
        self.filtersTableView.dataSource = self
        self.filtersTableView.delegate = self
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.76, green: 0.07, blue: 0, alpha: 0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

    }

    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchButton(sender: AnyObject) {
        var filters = [String : AnyObject]()
        
        var selectedCategories = [String]()
        for (row, isSelected) in categoriesSwitchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        
        let distanceInMiles = distances[distanceIndexSelected]["code"]!
        var radius = (distanceInMiles as NSString).doubleValue
        
        filters["categories"] = selectedCategories
        filters["offering_a_deal"] = offeringDealOn
        filters["radius"] = radius
        filters["sort_by"] = sortOptionsIndexSelected
        
        delegate?.filtersViewController!(self, didUpdateFilters : filters)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0: // OFFERING A DEAL
            return 1
        case 1: // DISTANCE
            if distancesExpanded {
                return distances.count
            } else {
                return 1
            }
        case 2: // SORT BY
            if sortOptionsExpanded {
                return sortOptions.count
            } else {
                return 1
            }
        case 3: // CATEGORIES
            return categories.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        
        if (section == 0) {
            // DEAL section
            cell.filterLabel.text = "Offering a Deal"
            cell.delegate = self
            cell.filterSwitch.on = offeringDealOn
            cell.filterSwitch.hidden = false
        } else if (section == 1) {
            // DISTANCE
            var rowIndex = indexPath.row
            if  !distancesExpanded {
                rowIndex = distanceIndexSelected
            }
            cell.filterLabel.text = distances[rowIndex]["name"]
            cell.delegate = nil
            cell.filterSwitch.hidden = true
        } else if (section == 2) {
            // SORT BY OPTIONS
            var rowIndex = indexPath.row
            if  !sortOptionsExpanded {
                rowIndex = sortOptionsIndexSelected
            }
            cell.filterLabel.text = sortOptions[rowIndex]
            cell.delegate = nil
            cell.filterSwitch.hidden = true
        } else if (section == 3) {
            // CATEGORIES
            cell.filterLabel.text = categories[indexPath.row]["name"]!
            cell.delegate = self
            cell.filterSwitch.on = categoriesSwitchStates[indexPath.row] ?? false
            cell.filterSwitch.hidden = false
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        println ("section \(section)")
        switch(section) {
        case 0: // OFFERING A DEAL
            return ""
        case 1: // DISTANCE
            return "Distance"
        case 2: // SORT BY
            return "Sort by"
        case 3: // CATEGORIES
            return "Category"
        default:
            return ""
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let section = indexPath.section
        switch (section) {
        case 0: // OFFERING A DEAL
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! SwitchCell
            cell.toggleFilterSwitch()
        case 1: // DISTANCE
            if (distancesExpanded) {
                distanceIndexSelected = indexPath.row
                distancesExpanded = false
            } else {
                distancesExpanded = true
            }
            tableView.reloadData()
        case 2: // SORT BY
            if (sortOptionsExpanded) {
                sortOptionsIndexSelected = indexPath.row
                sortOptionsExpanded = false
            } else {
                sortOptionsExpanded = true
            }
            tableView.reloadData()
        case 3: // CATEGORIES
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! SwitchCell
            cell.toggleFilterSwitch()
        default:
            return
        }
    }
    
    func switchCell(switchCell : SwitchCell, didChangeValue value: Bool) {
        let indexPath = filtersTableView.indexPathForCell(switchCell)!;
        switch (indexPath.section) {
        case 0: // OFFERING A DEAL
            offeringDealOn = value
        case 2: // CATEGORIES
            categoriesSwitchStates[indexPath.row] = value
        default:
            break;
        }
    }
    
    func getYelpDistanceOptions() -> [[String:String]] {
        return [
            ["name" : "Auto", "code": "25"],
            ["name" : "0.3mi", "code": "0.3"],
            ["name" : "1mi", "code": "1"],
            ["name" : "2mi", "code": "2"],
            ["name" : "5mi", "code": "5"]
        ]
    }
    
    func getYelpSortByOptions() -> [String] {
        return ["Best Match", "Distance", "HighestRated"]
    }
    
    func getYelpCategories() -> [[String:String]] {
        return [["name" : "Afghan", "code": "afghani"],
        ["name" : "African", "code": "african"],
        ["name" : "American, New", "code": "newamerican"],
        ["name" : "American, Traditional", "code": "tradamerican"],
        ["name" : "Arabian", "code": "arabian"],
        ["name" : "Argentine", "code": "argentine"],
        ["name" : "Armenian", "code": "armenian"],
        ["name" : "Asian Fusion", "code": "asianfusion"],
        ["name" : "Asturian", "code": "asturian"],
        ["name" : "Australian", "code": "australian"],
        ["name" : "Austrian", "code": "austrian"],
        ["name" : "Baguettes", "code": "baguettes"],
        ["name" : "Bangladeshi", "code": "bangladeshi"],
        ["name" : "Barbeque", "code": "bbq"],
        ["name" : "Basque", "code": "basque"],
        ["name" : "Bavarian", "code": "bavarian"],
        ["name" : "Beer Garden", "code": "beergarden"],
        ["name" : "Beer Hall", "code": "beerhall"],
        ["name" : "Beisl", "code": "beisl"],
        ["name" : "Belgian", "code": "belgian"],
        ["name" : "Bistros", "code": "bistros"],
        ["name" : "Black Sea", "code": "blacksea"],
        ["name" : "Brasseries", "code": "brasseries"],
        ["name" : "Brazilian", "code": "brazilian"],
        ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
        ["name" : "British", "code": "british"],
        ["name" : "Buffets", "code": "buffets"],
        ["name" : "Bulgarian", "code": "bulgarian"],
        ["name" : "Burgers", "code": "burgers"],
        ["name" : "Burmese", "code": "burmese"],
        ["name" : "Cafes", "code": "cafes"],
        ["name" : "Cafeteria", "code": "cafeteria"],
        ["name" : "Cajun/Creole", "code": "cajun"],
        ["name" : "Cambodian", "code": "cambodian"],
        ["name" : "Canadian", "code": "New)"],
        ["name" : "Canteen", "code": "canteen"],
        ["name" : "Caribbean", "code": "caribbean"],
        ["name" : "Catalan", "code": "catalan"],
        ["name" : "Chech", "code": "chech"],
        ["name" : "Cheesesteaks", "code": "cheesesteaks"],
        ["name" : "Chicken Shop", "code": "chickenshop"],
        ["name" : "Chicken Wings", "code": "chicken_wings"],
        ["name" : "Chilean", "code": "chilean"],
        ["name" : "Chinese", "code": "chinese"],
        ["name" : "Comfort Food", "code": "comfortfood"],
        ["name" : "Corsican", "code": "corsican"],
        ["name" : "Creperies", "code": "creperies"],
        ["name" : "Cuban", "code": "cuban"],
        ["name" : "Curry Sausage", "code": "currysausage"],
        ["name" : "Cypriot", "code": "cypriot"],
        ["name" : "Czech", "code": "czech"],
        ["name" : "Czech/Slovakian", "code": "czechslovakian"],
        ["name" : "Danish", "code": "danish"],
        ["name" : "Delis", "code": "delis"],
        ["name" : "Diners", "code": "diners"],
        ["name" : "Dumplings", "code": "dumplings"],
        ["name" : "Eastern European", "code": "eastern_european"],
        ["name" : "Ethiopian", "code": "ethiopian"],
        ["name" : "Fast Food", "code": "hotdogs"],
        ["name" : "Filipino", "code": "filipino"],
        ["name" : "Fish & Chips", "code": "fishnchips"],
        ["name" : "Fondue", "code": "fondue"],
        ["name" : "Food Court", "code": "food_court"],
        ["name" : "Food Stands", "code": "foodstands"],
        ["name" : "French", "code": "french"],
        ["name" : "French Southwest", "code": "sud_ouest"],
        ["name" : "Galician", "code": "galician"],
        ["name" : "Gastropubs", "code": "gastropubs"],
        ["name" : "Georgian", "code": "georgian"],
        ["name" : "German", "code": "german"],
        ["name" : "Giblets", "code": "giblets"],
        ["name" : "Gluten-Free", "code": "gluten_free"],
        ["name" : "Greek", "code": "greek"],
        ["name" : "Halal", "code": "halal"],
        ["name" : "Hawaiian", "code": "hawaiian"],
        ["name" : "Heuriger", "code": "heuriger"],
        ["name" : "Himalayan/Nepalese", "code": "himalayan"],
        ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
        ["name" : "Hot Dogs", "code": "hotdog"],
        ["name" : "Hot Pot", "code": "hotpot"],
        ["name" : "Hungarian", "code": "hungarian"],
        ["name" : "Iberian", "code": "iberian"],
        ["name" : "Indian", "code": "indpak"],
        ["name" : "Indonesian", "code": "indonesian"],
        ["name" : "International", "code": "international"],
        ["name" : "Irish", "code": "irish"],
        ["name" : "Island Pub", "code": "island_pub"],
        ["name" : "Israeli", "code": "israeli"],
        ["name" : "Italian", "code": "italian"],
        ["name" : "Japanese", "code": "japanese"],
        ["name" : "Jewish", "code": "jewish"],
        ["name" : "Kebab", "code": "kebab"],
        ["name" : "Korean", "code": "korean"],
        ["name" : "Kosher", "code": "kosher"],
        ["name" : "Kurdish", "code": "kurdish"],
        ["name" : "Laos", "code": "laos"],
        ["name" : "Laotian", "code": "laotian"],
        ["name" : "Latin American", "code": "latin"],
        ["name" : "Live/Raw Food", "code": "raw_food"],
        ["name" : "Lyonnais", "code": "lyonnais"],
        ["name" : "Malaysian", "code": "malaysian"],
        ["name" : "Meatballs", "code": "meatballs"],
        ["name" : "Mediterranean", "code": "mediterranean"],
        ["name" : "Mexican", "code": "mexican"],
        ["name" : "Middle Eastern", "code": "mideastern"],
        ["name" : "Milk Bars", "code": "milkbars"],
        ["name" : "Modern Australian", "code": "modern_australian"],
        ["name" : "Modern European", "code": "modern_european"],
        ["name" : "Mongolian", "code": "mongolian"],
        ["name" : "Moroccan", "code": "moroccan"],
        ["name" : "New Zealand", "code": "newzealand"],
        ["name" : "Night Food", "code": "nightfood"],
        ["name" : "Norcinerie", "code": "norcinerie"],
        ["name" : "Open Sandwiches", "code": "opensandwiches"],
        ["name" : "Oriental", "code": "oriental"],
        ["name" : "Pakistani", "code": "pakistani"],
        ["name" : "Parent Cafes", "code": "eltern_cafes"],
        ["name" : "Parma", "code": "parma"],
        ["name" : "Persian/Iranian", "code": "persian"],
        ["name" : "Peruvian", "code": "peruvian"],
        ["name" : "Pita", "code": "pita"],
        ["name" : "Pizza", "code": "pizza"],
        ["name" : "Polish", "code": "polish"],
        ["name" : "Portuguese", "code": "portuguese"],
        ["name" : "Potatoes", "code": "potatoes"],
        ["name" : "Poutineries", "code": "poutineries"],
        ["name" : "Pub Food", "code": "pubfood"],
        ["name" : "Rice", "code": "riceshop"],
        ["name" : "Romanian", "code": "romanian"],
        ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
        ["name" : "Rumanian", "code": "rumanian"],
        ["name" : "Russian", "code": "russian"],
        ["name" : "Salad", "code": "salad"],
        ["name" : "Sandwiches", "code": "sandwiches"],
        ["name" : "Scandinavian", "code": "scandinavian"],
        ["name" : "Scottish", "code": "scottish"],
        ["name" : "Seafood", "code": "seafood"],
        ["name" : "Serbo Croatian", "code": "serbocroatian"],
        ["name" : "Signature Cuisine", "code": "signature_cuisine"],
        ["name" : "Singaporean", "code": "singaporean"],
        ["name" : "Slovakian", "code": "slovakian"],
        ["name" : "Soul Food", "code": "soulfood"],
        ["name" : "Soup", "code": "soup"],
        ["name" : "Southern", "code": "southern"],
        ["name" : "Spanish", "code": "spanish"],
        ["name" : "Steakhouses", "code": "steak"],
        ["name" : "Sushi Bars", "code": "sushi"],
        ["name" : "Swabian", "code": "swabian"],
        ["name" : "Swedish", "code": "swedish"],
        ["name" : "Swiss Food", "code": "swissfood"],
        ["name" : "Tabernas", "code": "tabernas"],
        ["name" : "Taiwanese", "code": "taiwanese"],
        ["name" : "Tapas Bars", "code": "tapas"],
        ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
        ["name" : "Tex-Mex", "code": "tex-mex"],
        ["name" : "Thai", "code": "thai"],
        ["name" : "Traditional Norwegian", "code": "norwegian"],
        ["name" : "Traditional Swedish", "code": "traditional_swedish"],
        ["name" : "Trattorie", "code": "trattorie"],
        ["name" : "Turkish", "code": "turkish"],
        ["name" : "Ukrainian", "code": "ukrainian"],
        ["name" : "Uzbek", "code": "uzbek"],
        ["name" : "Vegan", "code": "vegan"],
        ["name" : "Vegetarian", "code": "vegetarian"],
        ["name" : "Venison", "code": "venison"],
        ["name" : "Vietnamese", "code": "vietnamese"],
        ["name" : "Wok", "code": "wok"],
        ["name" : "Wraps", "code": "wraps"],
        ["name" : "Yugoslav", "code": "yugoslav"]]
    }

}
