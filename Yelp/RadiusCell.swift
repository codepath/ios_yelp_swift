//
//  RadiusCell.swift
//  Yelp
//
//  Created by David Lundgren on 4/28/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

@objc protocol RadiusCellDelegate {
    optional func radiusCell(radiusCell: RadiusCell, didChangeValue value: String)
}

class RadiusCell: UITableViewCell {
    
    let cellType = "radius"
    weak var delegate: RadiusCellDelegate?
    @IBOutlet weak var radiusTextField: UITextField!
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        delegate?.radiusCell?(self, didChangeValue: radiusTextField.text)
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
