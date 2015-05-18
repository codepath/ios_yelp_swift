//
//  SwitchCell.swift
//  Yelp
//
//  Created by Sunny Rochiramani on 5/17/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwiftCellDelegate {
    optional func switchCell(switchCell : SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    weak var delegate : SwiftCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSwitchValueChanged(sender: AnyObject) {
        println("Switch value changed")
        delegate?.switchCell?(self, didChangeValue: filterSwitch.on)
    }
    
    func toggleFilterSwitch() {
        if filterSwitch.on {
            filterSwitch.on = false
        } else {
            filterSwitch.on = true
        }
    }
    
}
