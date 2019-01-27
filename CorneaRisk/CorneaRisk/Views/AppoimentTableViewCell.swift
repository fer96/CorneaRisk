//
//  AppoimentTableViewCell.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/23/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

protocol AppoimentCellDelegate {
    
}

class AppoimentTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var vaTextField: UITextField!
    @IBOutlet weak var transplantSwitch: UISwitch!
    @IBOutlet weak var complicationsTxtField: UITextField!
    
    var delegate: AppoimentCellDelegate?
    
}
