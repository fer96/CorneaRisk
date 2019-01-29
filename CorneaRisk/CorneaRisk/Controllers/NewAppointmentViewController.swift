//
//  NewAppointmentViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/28/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class NewAppointmentViewController: UIViewController {
    
    static var patient: Patient?
    var newAppointment: Appointment?
    
    @IBOutlet weak var dayTxtField: UITextField!
    @IBOutlet weak var monthTxtField: UITextField!
    @IBOutlet weak var yearTxtField: UITextField!
    @IBOutlet weak var vaTxtField: UITextField!
    @IBOutlet weak var transplantSwitch: UISwitch!
    @IBOutlet weak var complicationsTxtField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func changeDay(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func changeMonth(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func changeYear(_ sender: UITextField) {
        updateSaveButtonState()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        saveButton.isEnabled = false
        hideKeyboardWhenTappedAround()
        autoResizeScrollView()
    }
    
    //MARK: New appointment
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveNewAppointment" else { return }
        
        newAppointment = Appointment(socialSecurityNumber: (NewAppointmentViewController.patient?.socialSecurityNumber)!, date: stringToDate(toString(dayTxtField.text!, monthTxtField.text!, yearTxtField.text!)), visualAcuity: vaTxtField.text ?? "", transplant: transplantSwitch.isOn, complications: complicationsTxtField.text ?? "" , attended: false)
    }

}

extension NewAppointmentViewController {
    func toString(_ day: String, _ month: String, _ year: String) -> String {
        return day + "/" + month + "/" + year
    }
    func stringToDate(_ stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        guard let date = dateFormatter.date(from: stringDate) else {
            fatalError()
        }
        return date
    }
    func isInt(_ str: String) -> Bool {
        return Int(str) != nil
    }
    func checkDate(number: String, inf: Int, sup: Int) -> Bool{
        if (isInt(number) == true) {
            if (Int(number)! >= inf && Int(number)! <= sup) {
                return true
            }else {
                throwAlert("Error", "Review your date: \(number)")
                return false
            }
        }else {
            throwAlert("Error", "Review your date: \(number)")
            return false
        }
    }
    func checkValue() -> Bool {
        let day = dayTxtField.text ?? ""
        let month = monthTxtField.text ?? ""
        let year = yearTxtField.text ?? ""
        
        if (day.isEmpty == true || month.isEmpty == true || year.isEmpty == true){
            return false
        }else {
            return (checkDate(number: day, inf: 1, sup: 31) && checkDate(number: month, inf: 1, sup: 12) && checkDate(number: year, inf: 2019, sup: 2030))
        }
    }
    func updateSaveButtonState() {
        let state = checkValue()
        saveButton.isEnabled = state
    }
    func throwAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
