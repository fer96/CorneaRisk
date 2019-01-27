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
    func updateSaveButton(_ sender: UITextField) -> String
}

class ProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var patient: Patient?
    var appoiments = [Appointment]()
    var appoimentSended: Appointment?
    
    var vaString: String = ""
    var transplant: Bool = false
    var complicatoins: String = ""
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func changeVA(_ sender: UITextField) {
        //vaString = sender.text ?? ""
        vaString = updateSaveButton(sender)
    }
    @IBAction func changeTransplant(_ sender: UISwitch) {
        transplant = sender.isOn
    }
    @IBAction func changeComplications(_ sender: UITextField) {
        //complicatoins = sender.text ?? ""
        complicatoins = updateSaveButton(sender)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
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
        cell.complicationsTxtField.text = appoiment.complications
        cell.delegate = self as? AppoimentCellDelegate
        
        if (appoiment.date.string(with: "DD/MM/YYYY") != Date().string(with: "DD/MM/YYYY")) {
            enableAppoiment(cell, false)
        }else {
            enableAppoiment(cell, true)
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
        saveButton.isEnabled = false
        hideKeyboardWhenTappedAround()
        autoResizeScrollView()
        
    }
    
    //MARK: Edit Appoiment
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditAppoiment" else { return }
        
        appoimentSended = Appointment(socialSecurityNumber: (patient?.socialSecurityNumber)!, date: Date(), visualAcuity: vaString, transplant: transplant, complications: complicatoins , attended: true)
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
    func enableAppoiment(_ cell: AppoimentTableViewCell, _ set: Bool) {
        cell.isEditing = set
        cell.vaTextField.isEnabled = set
        cell.transplantSwitch.isEnabled = set
        cell.complicationsTxtField.isEnabled = set
    }
    func updateSaveButton(_ sender: UITextField) -> String {
        let text = sender.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        return text
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
