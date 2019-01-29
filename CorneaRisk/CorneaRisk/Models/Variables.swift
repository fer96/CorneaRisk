//
//  Variables.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/22/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import Foundation

struct Variable {
    //MARK: Txt fields
    //Age example: -60 --> 0, 60|+60 --> 1
    var age: Int = 0
    
    //MARK: Switchs
    //Sex example: male -> 0, female -> 1
    //Gruop risk example: low -> 0, high -> 1
    //systematic comorbidities example: absent -> 0, present -> 1
    var sex: Int  = 0
    var groupRisk: Int = 0
    var bloodCompatibility: Int = 0
    //var vascularization: Bool = false
    var systematicComorbidities: Int = 0
    var ophthalmicComorbidities: Int = 0
    var postsurgicalComplications: Int = 0
    
    //MARK: Segmented Controls
    //Graft size example: -7.25 -> 0, 7.50 a 8.25 -> 1, +8.50 -> 3
    //Type of transplant example: Simple -> 0, Triple -> 1
    //Surgical Time example: menos de 1 hr -> 0, más de 1 hr -> 1
    var graftSize: Int = 0
    var typeOfTransplant: Int = 0
    var surgicalTime: Int = 0
    
    //MARK: Methods
    mutating func setAge(_ age: Int) {
        if (age < 60){
            self.age = 0
        }else {
            self.age = 1
        }
    }
    func boolToInt(_ value: Bool) -> Int {
        if value == true {
            return 1
        }else {
            return 0
        }
    }
}

