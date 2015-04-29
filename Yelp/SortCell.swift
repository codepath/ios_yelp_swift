//
//  SortCell.swift
//  Yelp
//
//  Created by David Lundgren on 4/28/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

@objc protocol SortCellDelegate {
    optional func sortCell(sortCell: SortCell, didChangeValue value: Int)
}

class SortCell: UITableViewCell {
    weak var delegate: SortCellDelegate?
    let cellType = "sort"
    let sortTypes = [YelpSortMode.BestMatched, YelpSortMode.Distance, YelpSortMode.HighestRated]
    
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    @IBAction func onValueChanged(sender: AnyObject) {
        let sortType = sortTypes[sortSegment.selectedSegmentIndex].rawValue
        delegate?.sortCell?(self, didChangeValue: sortType)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
