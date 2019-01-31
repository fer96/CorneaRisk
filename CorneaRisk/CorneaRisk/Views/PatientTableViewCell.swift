//
//  PatientTableViewCell.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/23/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

protocol PatientCellDelegate {
    
}

class PatientTableViewCell: UITableViewCell {

    var delegate: PatientCellDelegate?
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var ssNumberLabel: UILabel!

}
