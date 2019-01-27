//
//  Appointment.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/22/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import Foundation

struct Appointment: Codable {
    let socialSecurityNumber: String
    let date: Date
    let visualAcuity: String
    let transplant: Bool
    let complications: String
    let attended: Bool
    
    //MARK: Load
    static func loadAppoiments() -> [Appointment]?{
        guard let codedAppoiments = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Appointment>.self, from: codedAppoiments)
    }
    static func loadSampleAppoiments() -> [Appointment] {
//        let appoiment1 = Appointment(socialSecurityNumber: "999666999", date: Date(), visualAcuity: "16/20", transplant: true, complications: "No one", attended: true)
//        let appoiment2 = Appointment(socialSecurityNumber: "999666999", date: Date(timeIntervalSinceNow: 604800), visualAcuity: "18/20", transplant: true, complications: "No one", attended: true)
//        let appoiment3 = Appointment(socialSecurityNumber: "999666999", date: Date(timeIntervalSinceNow: 604800 * 2), visualAcuity: "20/20", transplant: true, complications: "No one", attended: true)
//        return [appoiment1,appoiment2,appoiment3]
        return []
    }
    static func appoimentsFrom(_ patient: Patient, _ appoiments: [Appointment]) -> [Appointment] {
        var appoimentsPatient: [Appointment] = []
        for appoiment in appoiments {
            if appoiment.socialSecurityNumber == patient.socialSecurityNumber {
                appoimentsPatient.append(appoiment)
            }else {
                //Nothing
            }
        }
        return appoimentsPatient
    }
    
    //MARK: Archiving
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("appoiments").appendingPathExtension("plist")
    static func saveAppoiments(_ appoiments: [Appointment]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedAppoiments = try? propertyListEncoder.encode(appoiments)
        try? codedAppoiments?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
}
