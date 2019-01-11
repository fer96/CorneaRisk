//
//  CorneaFormViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class CorneaFormViewController: UIViewController {
    
    var patient = Patient()
    let imssMainColor = UIColor(red: CGFloat(0.0), green: CGFloat(0.2), blue: CGFloat(0.145), alpha: CGFloat(1))
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var groupRiskSegmentControl: UISegmentedControl!
    @IBOutlet weak var vascularizationSwitch: UISwitch!
    @IBOutlet weak var bloodCompatibilitySwitch: UISwitch!
    @IBOutlet weak var systematicComorbitiesSwitch: UISwitch!
    @IBOutlet weak var sizeGraftSegmentControl: UISegmentedControl!
    @IBOutlet weak var typeTransplantSegmentControl: UISegmentedControl!
    @IBOutlet weak var resetButtonO: UIButton!
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        resetValues()
    }
    
    @IBAction func resultsButton(_ sender: UIBarButtonItem) {
        if (chechkValues() == true) {
            performSegue(withIdentifier: "resultsSegue", sender: nil)
        } else {
            //Lanzar alerta
            resetValues()
        }
    }
    
    func resetValues() {
        ageTextField.text = ""
        ageTextField.placeholder = "Age must be between 20 - 90"
        sexSegmentControl.selectedSegmentIndex = 0
        groupRiskSegmentControl.selectedSegmentIndex = 0
        vascularizationSwitch.setOn(false, animated: false)
        bloodCompatibilitySwitch.setOn(false, animated: false)
        systematicComorbitiesSwitch.setOn(false, animated: false)
        sizeGraftSegmentControl.selectedSegmentIndex = 0
        typeTransplantSegmentControl.selectedSegmentIndex = 0
    }
    
    func isInt(str: String) -> Bool {
        return Int(str) != nil
    }
    
    func setValuesToPatient() {
        if (ageTextField.text?.isEmpty == false && isInt(str: String(ageTextField.text!)) == true ){
            patient.age = Int(ageTextField.text!)!
        }else {
            patient.age = 0
            ageTextField.placeholder = "Age must be between 20 - 90"
        }
        patient.sex = sexSegmentControl.selectedSegmentIndex
        patient.groupRisk = groupRiskSegmentControl.selectedSegmentIndex
        patient.vascularization = vascularizationSwitch.isOn
        patient.bloodCompatibility = bloodCompatibilitySwitch.isOn
        patient.systematicComorbidities = systematicComorbitiesSwitch.isOn
        patient.graftSize = sizeGraftSegmentControl.selectedSegmentIndex
        patient.typeOfTransplant = typeTransplantSegmentControl.selectedSegmentIndex
    }
    
    func chechkValues() -> Bool {
        setValuesToPatient()
        
        if(patient.age > 20 && patient.age < 90){
            return true
        } else {
            return false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetButtonO.layer.cornerRadius = 9
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : imssMainColor]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
