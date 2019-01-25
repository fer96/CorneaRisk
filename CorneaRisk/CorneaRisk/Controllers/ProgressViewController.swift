//
//  ProgressViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/23/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

protocol AppoimentManager {
    func enableAppoiment(_ cell: AppoimentTableViewCell, _ set: Bool)
    func copyAppoiment(_ old: Appointment, _ cell: AppoimentTableViewCell) -> Appointment
    func updateStateSaveButton(_ cell: AppoimentTableViewCell)
}

class ProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var patient: Patient?
    var appoiments = [Appointment]()
    var appoimentEdited: Appointment?
    var appoimentSended: Appointment?
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func visualAcuityTxtField(_ sender: UITextField) {
        updateStateSaveButton(AppoimentTableViewCell())
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appoiments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppoimentCell") as? AppoimentTableViewCell else {
            fatalError("Could not dequeue a cell.")
        }
        
        let appoiment = appoiments[indexPath.row]
        cell.dateLabel.text = appoiment.date.string(with: "dd/MM/YYYY")
        cell.vaTextField.text = appoiment.visualAcuity
        cell.transplantSwitch.setOn(appoiment.transplant, animated: false)
        cell.complicationsTextView.text = appoiment.complications
        cell.delegate = self as? AppoimentCellDelegate
        
        if (appoiment.date.string(with: "DD/MM/YYYY") != Date().string(with: "DD/MM/YYYY")) {
            enableAppoiment(cell, false)
        }else {
            enableAppoiment(cell, true)
            appoimentEdited = copyAppoiment(appoiment, cell)
            updateStateSaveButton(cell)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(216.0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let saveAppoiments = Appointment.loadAppoiments() {
            appoiments = Appointment.appoimentsFrom(patient!, saveAppoiments)
        }else {
            appoiments = Appointment.appoimentsFrom(patient!, Appointment.loadSampleAppoiments())
        }
        
    }
    
    //MARK: Edit Appoiment
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditAppoiment" else { return }
        
        appoimentSended = appoimentEdited
    }

}
extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension ProgressViewController: AppoimentManager {
    func copyAppoiment(_ old: Appointment, _ cell: AppoimentTableViewCell) -> Appointment {
        return Appointment(socialSecurityNumber: old.socialSecurityNumber, date: old.date, visualAcuity: cell.vaTextField.text!, transplant: cell.transplantSwitch.isOn, complications: cell.complicationsTextView.text ?? "", attended: true)
    }
    func enableAppoiment(_ cell: AppoimentTableViewCell, _ set: Bool) {
        cell.isEditing = set
        cell.vaTextField.isEnabled = set
        cell.transplantSwitch.isEnabled = set
        cell.complicationsTextView.isSelectable = set
        cell.complicationsTextView.isEditable = set
    }
    func updateStateSaveButton(_ cell: AppoimentTableViewCell) {
//        let text = cell.vaTextField.text ?? ""
//        saveButton.isEnabled = !text.isEmpty
    }
}
