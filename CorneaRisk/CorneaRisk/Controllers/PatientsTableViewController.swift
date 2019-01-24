//
//  PatientsTableViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/23/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class PatientsTableViewController: UITableViewController, PatientCellDelegate {
    
    
    var patients = [Patient]()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return patients.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell") as? PatientTableViewCell else {
            fatalError("Could not dequeue a cell.")
        }

        let patient = patients[indexPath.row]
        cell.patientNameLabel.text = patient.lastName + " " + patient.name
        cell.ssNumberLabel.text = patient.socialSecurityNumber
        cell.delegate = self
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(72.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let savePatients = Patient.loadPatients(){
            patients = savePatients
        }else{
            patients = Patient.loadSamplePatients()
        }
    }
    
    //MARK: Delete items
    override func tableView(_ tableView: UITableView, canEditRowAt
        indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
        IndexPath) {
        if editingStyle == .delete {
            patients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Patient.savePatients(patients)
        }
    }
    
    //MARK: Patient appoiments
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PatientAppoiments" {
            let progressViewController = segue.destination as! ProgressViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedPatient = patients[indexPath.row]
            
            progressViewController.patient = selectedPatient
        }
    }
}
