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
        return []
    }
}
