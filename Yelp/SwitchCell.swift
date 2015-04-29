//
//  SwitchCell.swift
//  Yelp
//
//  Created by David Lundgren on 4/27/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    var cellType: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
        delegate?.switchCell?(self, didChangeValue: onSwitch.on)
    }

}
