//
//  ProgressTableViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/27/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

protocol AppoimentManager {
    func enableAppoiment(_ cell: AppoimentTableViewCell, _ set: Bool)
    func updateStringFromTxtField(_ sender: UITextField) -> String
}

class ProgressTableViewController: UITableViewController {

    var patient: Patient?
    var appoiments = [Appointment]()
    var appoimentSended: Appointment?
    
    var vaString: String = ""
    var transplant: Bool = false
    var complicatoins: String = ""
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func changeVA(_ sender: UITextField) {
        vaString = updateStringFromTxtField(sender)
        saveButton.isEnabled = checkValue()
    }
    @IBAction func changeTransplant(_ sender: UISwitch) {
        transplant = sender.isOn
    }
    @IBAction func changeComplications(_ sender: UITextField) {
        complicatoins = updateStringFromTxtField(sender)
    }
    
    
    
    @IBAction func addAppointment(_ sender: UIButton) {
        performSegue(withIdentifier: "NewAppointment", sender: nil)
        NewAppointmentViewController.patient = patient
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let saveAppoiments = Appointment.loadAppoiments() {
            appoiments = Appointment.appoimentsFrom(patient!, saveAppoiments)
        }else {
            appoiments = Appointment.appoimentsFrom(patient!, Appointment.loadSampleAppoiments())
        }
        saveButton.isEnabled = false
        hideKeyboardWhenTappedAround()
        autoResizeScrollView()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appoiments.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppoimentCell") as? AppoimentTableViewCell else {
                fatalError("Could not dequeue a cell.")
            }
            
        let appoiment = appoiments[indexPath.row]
        cell.dateLabel.text = appoiment.date.string(with: "dd/MM/YYYY")
        cell.vaTextField.text = appoiment.visualAcuity
        cell.transplantSwitch.setOn(appoiment.transplant, animated: false)
        cell.complicationsTxtField.text = appoiment.complications
        cell.delegate = self as? AppoimentCellDelegate
        
        if (appoiment.date.string(with: "DD/MM/YYYY") != Date().string(with: "DD/MM/YYYY")) {
            enableAppoiment(cell, false)
        }else {
            enableAppoiment(cell, true)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(216.0)
    }

    //MARK: Edit Appoiment
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditAppoiment" else { return }
        
        appoimentSended = Appointment(socialSecurityNumber: (patient?.socialSecurityNumber)!, date: Date(), visualAcuity: vaString, transplant: transplant, complications: complicatoins , attended: true)
    }
    
    //MARK: Save new appointment
    @IBAction func unwindNewAppointment(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveNewAppointment" else { return }
        
        let sourceViewController = segue.source as! NewAppointmentViewController
        
        if let appointment = sourceViewController.newAppointment {
            var oldAppointments = appoiments
            oldAppointments.append(appointment)
            oldAppointments.sort { (app1, app2) -> Bool in
                return app1.date < app2.date
            }
            appoiments = oldAppointments
        }
        Appointment.saveAppoiments(appoiments)
        tableView.reloadData()
    }
    
}

extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension ProgressTableViewController: AppoimentManager {
    
    //MARK: Enable appointments
    func enableAppoiment(_ cell: AppoimentTableViewCell, _ set: Bool) {
        cell.isEditing = set
        cell.vaTextField.isEnabled = set
        cell.transplantSwitch.isEnabled = set
        cell.complicationsTxtField.isEnabled = set
        
    }
    
    //MARK: Update appointment
    func updateStringFromTxtField(_ sender: UITextField) -> String {
        let text = sender.text ?? ""
        return text
    }
    func isInt(_ str: String) -> Bool {
        return Int(str) != nil
    }
    func checkValue() -> Bool{
        let va = vaString
        return !va.isEmpty && isInt(va)
    }
    
    //MARK: Hide keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SavePatientViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Scroll View
    func autoResizeScrollView() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = UIEdgeInsets.zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
}
