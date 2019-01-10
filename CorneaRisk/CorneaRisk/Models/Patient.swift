//
//  Patient.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import Foundation


struct Patient {
    //MARK: Txt fields
    var age: Int
    
    //MARK: Switchs
    //Sex example: male -> 0, female -> 1
    //Gruop risk example: low -> 0, high -> 1
    //systematic comorbidities example: absent -> 0, present -> 1
    var sex: Int
    var groupRisk: Int
    var bloodCompatibility: Bool
    var vascularization: Bool
    var systematicComorbidities: Int
    
    //MARK: Pikers
    //Graft size example: -8.25 -> 0, 8.25 -> 1, 8.50 ->2, +8.50 -> 3
    //Type of transplant example: just one -> 0, Double procedure -> 1, Triple procedure -> 2
    var graftSize: Int
    var typeOfTransplant: Int
}
