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
        dayTxtField.text = updateSaveButton(sender)
    }
    @IBAction func changeMonth(_ sender: UITextField) {
        monthTxtField.text = updateSaveButton(sender)
    }
    @IBAction func changeYear(_ sender: UITextField) {
        yearTxtField.text = updateSaveButton(sender)
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
        
        newAppointment = Appointment(socialSecurityNumber: (NewAppointmentViewController.patient?.socialSecurityNumber)!, date: Date(), visualAcuity: vaTxtField.text ?? "", transplant: transplantSwitch.isOn, complications: complicationsTxtField.text ?? "" , attended: false)
    }

}

extension NewAppointmentViewController: AppoimentManager {
    func enableAppoiment(_ cell: AppoimentTableViewCell, _ set: Bool) {
        //Nothing
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
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
