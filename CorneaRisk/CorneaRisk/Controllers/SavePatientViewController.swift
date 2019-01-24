//
//  SavePatientViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/23/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

protocol SavePatient {
    func checkValues() -> Bool
    func savePatient()
}

class SavePatientViewController: UIViewController {

    @IBOutlet weak var crResultTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var secondLNTextField: UITextField!
    @IBOutlet weak var ssNumberTextField: UITextField!
    
    @IBAction func saveButton(_ sender: UIButton) {
        if checkValues() == true {
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                guard segue.identifier == "SavePatient" else {return}
                savePatient()
            }
        }else {
            let alert = UIAlertController(title: "Error", message: "Couldn't save new patient", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    var patient: Patient?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    
    

}

extension SavePatientViewController: SavePatient {
    func checkValues() -> Bool {
        if (nameTextField.text?.isEmpty == false && lastNameTextField.text?.isEmpty == false && secondLNTextField.text?.isEmpty == false && ssNumberTextField.text?.isEmpty == false && crResultTextField.text?.isEmpty == false) {
            return true
        }else {
            let alert = UIAlertController(title: "Error", message: "Please review your data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
    }
    func savePatient() {
        
        let name = nameTextField.text
        let lastName = lastNameTextField.text
        let secondLastName = secondLNTextField.text
        let ssn = ssNumberTextField.text
        let crResult = crResultTextField.text
                
        patient = Patient(name: name!, lastName: lastName!, secondLastName: secondLastName!, socialSecurityNumber: ssn!, resultCRC: crResult!)
    }
}
