//
//  Patient.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import Foundation


struct Patient {
    let name: String
    let lastName: String
    let secondLastName: String
    let socialSecurityNumber: String
    let resultCRC: String
    
    let appoiments: [Appointment] = []
}
