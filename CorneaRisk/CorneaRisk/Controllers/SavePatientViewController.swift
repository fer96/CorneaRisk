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
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        crResultTextField.placeholder = "Result must be between 1 - 100"
        updateSaveButtonState()
        
        //MARK: Hide keyboard
        hideKeyboardWhenTappedAround()
        
        //MARK: Scroll view
        autoResizeScrollView()

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
            return (checkCRR() && checkSSN(ssn))
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
    func checkSSN(_ ssn: String) -> Bool {
        return isInt(ssn)
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
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
