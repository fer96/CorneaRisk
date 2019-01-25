//
//  SavePatientViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/23/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

protocol SavePatient {
    func isInt(_ str: String) -> Bool
    func checkValue() -> Bool
    func updateSaveButtonState()
}

class SavePatientViewController: UIViewController {

    var patient: Patient?
    
    @IBOutlet weak var crResultTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var secondLNTextField: UITextField!
    @IBOutlet weak var ssNumberTextField: UITextField!
    
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func nameTxtField(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func lastNameTxtField(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func secondLNTxtField(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func ssNumberTxtField(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func crResultTxtField(_ sender: UITextField) {
        if checkCRR() == true {
            updateSaveButtonState()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        crResultTextField.placeholder = "Result must be between 1 - 100"
        updateSaveButtonState()
    }
    
    //MARK: Save patient
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SavePatient" else { return }
        
        let name = nameTextField.text
        let lastName = lastNameTextField.text
        let secondLastName = secondLNTextField.text
        let ssn = ssNumberTextField.text
        let crResult = crResultTextField.text
            
        patient = Patient(name: name!, lastName: lastName!, secondLastName: secondLastName!, socialSecurityNumber: ssn!, resultCRC: crResult!)
    }
}

extension SavePatientViewController: SavePatient {
    func updateSaveButtonState() {
        let state = checkValue()
        saveButton.isEnabled = state
    }
    func throwAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func isInt(_ str: String) -> Bool {
        return Int(str) != nil
    }
    func checkValue() -> Bool {
        let name = nameTextField.text ?? ""
        let lName = lastNameTextField.text ?? ""
        let sLName = secondLNTextField.text ?? ""
        let ssn = ssNumberTextField.text ?? ""
        let crr = crResultTextField.text ?? ""
        
        if (name.isEmpty == true || sLName.isEmpty == true || lName.isEmpty == true || ssn.isEmpty == true || crr.isEmpty == true){
            return false
        }else {
            return checkCRR()
        }
    }
    func checkCRR() -> Bool{
        if (isInt(String(crResultTextField.text!)) == true) {
            if (Int(crResultTextField.text!)! >= 0 && Int(crResultTextField.text!)! <= 100) {
                return true
            }else {
                crResultTextField.text = ""
                crResultTextField.placeholder = "Result must be between 1 - 100"
                return false
            }
        }else {
            crResultTextField.text = ""
            crResultTextField.placeholder = "This value must be a number"
            return false
        }
    }
}
