//
//  Business.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FilterState {
    
    let categories : Dictionary<String,String> = [
        "afghani": "Afghan",
        "african": "African",
        "newamerican": "American, new",
        "tradamerican": "American, traditional",
        "arabian": "Arabian",
        "argentine": "Argentine",
        "armenian": "Armenian",
        "asianfusion": "Asian Fusion",
        "asturian": "Asturian",
        "australian": "Australian",
        "austrian": "Austrian",
        "baguettes": "Baguettes",
        "bangladeshi": "Bangladeshi",
        "bbq": "Barbeque",
        "basque": "Basque",
        "bavarian": "Bavarian",
        "beergarden": "Beer Garden",
        "beerhall": "Beer Hall",
        "beisl": "Beisl",
        "belgian": "Belgian",
        "bistros": "Bistros",
        "blacksea": "Black Sea",
        "brasseries": "Brasseries",
        "brazilian": "Brazilian",
        "breakfast_brunch": "Breakfast & Brunch",
        "british": "British",
        "buffets": "Buffets",
        "bulgarian": "Bulgarian",
        "burgers": "Burgers",
        "burmese": "Burmese",
        "cafes": "Cafes",
        "cafeteria": "Cafeteria",
        "cajun": "Cajun/Creole",
        "cambodian": "Cambodian",
        "canteen": "Canteen",
        "caribbean": "Caribbean",
        "catalan": "Catalan",
        "chech": "Chech",
        "cheesesteaks": "Cheesesteaks",
        "chickenshop": "Chicken Shop",
        "chicken_wings": "Chicken Wings",
        "chilean": "Chilean",
        "chinese": "Chinese",
        "comfortfood": "Comfort Food",
        "corsican": "Corsican",
        "creperies": "Creperies",
        "cuban": "Cuban",
        "currysausage": "Curry Sausage",
        "cypriot": "Cypriot",
        "czech": "Czech",
        "czechslovakian": "Czech/Slovakian",
        "danish": "Danish",
        "delis": "Delis",
        "diners": "Diners",
        "dumplings": "Dumplings",
        "eastern_european": "Eastern European",
        "ethiopian": "Ethiopian",
        "hotdogs": "Fast Food",
        "filipino": "Filipino",
        "fishnchips": "Fish & Chips",
        "fondue": "Fondue",
        "food_court": "Food Court",
        "foodstands": "Food Stands",
        "sud_ouest": "French Southwest",
        "french": "French",
        "galician": "Galician",
        "gastropubs": "Gastropubs",
        "georgian": "Georgian",
        "german": "German",
        "giblets": "Giblets",
        "gluten_free": "Gluten-Free",
        "greek": "Greek",
        "halal": "Halal",
        "hawaiian": "Hawaiian",
        "heuriger": "Heuriger",
        "himalayan": "Himalayan/Nepalese",
        "hkcafe": "Hong Kong Style Cafe",
        "hotdog": "Hot Dogs",
        "hotpot": "Hot Pot",
        "hungarian": "Hungarian",
        "iberian": "Iberian",
        "indpak": "Indian",
        "indonesian": "Indonesian",
        "international": "International",
        "irish": "Irish",
        "island_pub": "Island Pub",
        "israeli": "Israeli",
        "italian": "Italian",
        "japanese": "Japanese",
        "jewish": "Jewish",
        "kebab": "Kebab",
        "korean": "Korean",
        "kosher": "Kosher",
        "kurdish": "Kurdish",
        "laos": "Laos",
        "laotian": "Laotian",
        "latin": "Latin American",
        "raw_food": "Live/Raw Food",
        "lyonnais": "Lyonnais",
        "malaysian": "Malaysian",
        "meatballs": "Meatballs",
        "mediterranean": "Mediterranean",
        "mexican": "Mexican",
        "mideastern": "Middle Eastern",
        "milkbars": "Milk Bars",
        "modern_australian": "Modern Australian",
        "modern_european": "Modern European",
        "mongolian": "Mongolian",
        "moroccan": "Moroccan",
        "newzealand": "New Zealand",
        "nightfood": "Night Food",
        "norcinerie": "Norcinerie",
        "opensandwiches": "Open Sandwiches",
        "oriental": "Oriental",
        "pakistani": "Pakistani",
        "eltern_cafes": "Parent Cafes",
        "parma": "Parma",
        "persian": "Persian/Iranian",
        "peruvian": "Peruvian",
        "pita": "Pita",
        "pizza": "Pizza",
        "polish": "Polish",
        "portuguese": "Portuguese",
        "potatoes": "Potatoes",
        "poutineries": "Poutineries",
        "pubfood": "Pub Food",
        "riceshop": "Rice",
        "romanian": "Romanian",
        "rotisserie_chicken": "Rotisserie Chicken",
        "rumanian": "Rumanian",
        "russian": "Russian",
        "salad": "Salad",
        "sandwiches": "Sandwiches",
        "scandinavian": "Scandinavian",
        "scottish": "Scottish",
        "seafood": "Seafood",
        "serbocroatian": "Serbo Croatian",
        "signature_cuisine": "Signature Cuisine",
        "singaporean": "Singaporean",
        "slovakian": "Slovakian",
        "soulfood": "Soul Food",
        "soup": "Soup",
        "southern": "Southern",
        "spanish": "Spanish",
        "steak": "Steakhouses",
        "sushi": "Sushi Bars",
        "swabian": "Swabian",
        "swedish": "Swedish",
        "swissfood": "Swiss Food",
        "tabernas": "Tabernas",
        "taiwanese": "Taiwanese",
        "tapas": "Tapas Bars",
        "tapasmallplates": "Tapas/Small Plates",
        "tex-mex": "Tex-Mex",
        "thai": "Thai",
        "norwegian": "Traditional Norwegian",
        "traditional_swedish": "Traditional Swedish",
        "trattorie": "Trattorie",
        "turkish": "Turkish",
        "ukrainian": "Ukrainian",
        "uzbek": "Uzbek",
        "vegan": "Vegan",
        "vegetarian": "Vegetarian",
        "venison": "Venison",
        "vietnamese": "Vietnamese",
        "wok": "Wok",
        "wraps": "Wraps",
        "yugoslav": "Yugoslav"
    ]
    
    // Array of tuplearrays of form (catkey, cattitle)
    var arrayCategories : [[String]] = []
    
    // Maps row index to boolean
    var selectionStatus : [Bool] = []

    var maxDistance : Float = 5.0
    var boolLookOnlyForDeals = false


    var curSortModeIndex = 0
    let sortModes_Ordering = [ YelpSortMode.Distance, YelpSortMode.BestMatched, YelpSortMode.HighestRated ]
    
    
    init() {
        let arrayCatkeys = (Array(categories.keys)).sorted {
            // Our goal is to sort the categories by the display titles (not by the keys)
            let left = self.categories[$0]!
            let right = self.categories[$1]!
            return left.localizedCaseInsensitiveCompare($1) == NSComparisonResult.OrderedAscending
        }
        
        for x in arrayCatkeys {
            arrayCategories.append([x, self.categories[x]!])
            selectionStatus.append(false)
        }
    }
    
    
    // This is needed because Swift does not offer an automatic support for deep copying.
    func initFromOther(other:FilterState) {
        self.selectionStatus = other.selectionStatus
        self.maxDistance = other.maxDistance
        self.boolLookOnlyForDeals = other.boolLookOnlyForDeals
        self.curSortModeIndex = other.curSortModeIndex
    }
    

    // The Yelp API wants an array listing just the categories desired, so I need
    // to map the sparse selectionStatus array-of-bool into that non-sparse format.
    func getSetOfDesiredCategories() -> [String]? {
        var result : [String] = []
        for idx in 0...(selectionStatus.count-1) {
            if selectionStatus[idx] {
               result.append(arrayCategories[idx][0])
            }
        }
        if result.count == 0 {
            return nil
        }else{
            return result
        }
    }   
    
}
