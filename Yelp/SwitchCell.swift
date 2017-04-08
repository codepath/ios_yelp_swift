//
//  SwitchCell.swift
//  Yelp
//
//  Created by Arthur Burgin on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(SwitchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet var onSwitch: UISwitch!
    @IBOutlet var switchLabel: UILabel!
    
    var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        onSwitch.addTarget(self, action: #selector(onToggle), for: .valueChanged)
    }
    
    func onToggle(){
        delegate?.switchCell?(SwitchCell: self, didChangeValue: onSwitch.isOn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
