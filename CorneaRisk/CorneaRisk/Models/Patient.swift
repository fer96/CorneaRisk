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
    var age: Int = 0
    
    //MARK: Switchs
    //Sex example: male -> 0, female -> 1
    //Gruop risk example: low -> 0, high -> 1
    //systematic comorbidities example: absent -> 0, present -> 1
    var sex: Int  = 0
    var groupRisk: Int = 0
    var bloodCompatibility: Bool = false
    var vascularization: Bool = false
    var systematicComorbidities: Bool = false
    var ophthalmicComorbidities: Bool = false
    var postsurgicalComplications: Bool = false
    
    //MARK: Pikers
    //Graft size example: -8.25 -> 0, 8.25 -> 1, 8.50 ->2, +8.50 -> 3
    //Type of transplant example: just one -> 0, Double procedure -> 1, Triple procedure -> 2
    //Surgical Time example: menos de 1 hr -> 0, 1 hr -> 1, más de 1 hr -> 2
    var graftSize: Int = 0
    var typeOfTransplant: Int = 0
    var surgicalTime: Int = 0
}
