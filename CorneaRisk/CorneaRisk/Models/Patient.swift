//
//  Patient.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import Foundation

protocol CreateAppoiments {
    func newAppoiments() -> [Appointment]
}

struct Patient: Codable {
    var name: String
    var lastName: String
    var secondLastName: String
    var socialSecurityNumber: String
    var resultCRC: String
    
    //MARK: Load
    static func loadPatients() -> [Patient]?{
        guard let codedPatients = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Patient>.self, from: codedPatients)
    }
    static func loadSamplePatients() -> [Patient] {
//        let patient1 = Patient(name: "Fernando", lastName: "De La Rosa", secondLastName: "Salas", socialSecurityNumber: "999666999", resultCRC: "96")
//        let patient2 = Patient(name: "Pablo", lastName: "De La Rosa", secondLastName: "Salas", socialSecurityNumber: "555666999", resultCRC: "16")
//        let patient3 = Patient(name: "Uriel", lastName: "De La Rosa", secondLastName: "Salas", socialSecurityNumber: "111666999", resultCRC: "56")
//        return [patient1,patient2,patient3]
        return []
    }
    
    //MARK: Archiving
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("patients").appendingPathExtension("plist")
    
    static func savePatients(_ patients: [Patient]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedPatients = try? propertyListEncoder.encode(patients)
        try? codedPatients?.write(to: ArchiveURL, options: .noFileProtection)
    }
}

extension Patient: CreateAppoiments {
    func newAppoiments() -> [Appointment] {
        if(Int(Double(self.resultCRC)!) < 50){
            let appoiment1 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(), visualAcuity: "", transplant: false, complications: "", attended: false)
            let appoiment2 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(timeIntervalSinceNow: 604800 * 2), visualAcuity: "", transplant: false, complications: "", attended: false)
            let appoiment3 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(timeIntervalSinceNow: 604800 * 4), visualAcuity: "", transplant: false, complications: "", attended: false)
            return [appoiment1,appoiment2,appoiment3]
        }else {
            let appoiment1 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(), visualAcuity: "", transplant: false, complications: "", attended: false)
            let appoiment2 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(timeIntervalSinceNow: 604800 * 2), visualAcuity: "", transplant: false, complications: "", attended: false)
            let appoiment3 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(timeIntervalSinceNow: 604800 * 3), visualAcuity: "", transplant: false, complications: "", attended: false)
            let appoiment4 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(timeIntervalSinceNow: 604800 * 4), visualAcuity: "", transplant: false, complications: "", attended: false)
            let appoiment5 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(timeIntervalSinceNow: 604800 * 5), visualAcuity: "", transplant: false, complications: "", attended: false)
            let appoiment6 = Appointment(socialSecurityNumber: self.socialSecurityNumber, date: Date(timeIntervalSinceNow: 604800 * 6), visualAcuity: "", transplant: false, complications: "", attended: false)
            return [appoiment1,appoiment2,appoiment3,appoiment4,appoiment5,appoiment6]
        }
    }
}
