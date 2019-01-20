//
//  FormTableViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/18/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

protocol setValuesCalculator {
    func resetBasicData()
    func resetRiskValues()
    func resetComorbiditiesValues()
    func isInt(_ str: String) -> Bool
    func checkValues() -> Bool
    func setValuesToPatient()
    func countTrue(_ array: [Bool]) -> Int
    func setSystematicComorbidities() -> Int
    func setGroupRisk() -> Int
}


class FormTableViewController: UITableViewController {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var sexControl: UISegmentedControl!
    @IBOutlet weak var sizeGraftControl: UISegmentedControl!
    @IBOutlet weak var typeTransplantControl: UISegmentedControl!
    @IBOutlet weak var timeSurgicalControl: UISegmentedControl!
    @IBOutlet weak var herpeticLeukomaSwitch: UISwitch!
    @IBOutlet weak var perforatedUlcersSwitch: UISwitch!
    @IBOutlet weak var syndromeSJSwitch: UISwitch!
    @IBOutlet weak var rejectionSwitch: UISwitch!
    @IBOutlet weak var bacterialKeratitisSwitch: UISwitch!
    @IBOutlet weak var retrasplantSwitch: UISwitch!
    @IBOutlet weak var neurotrophicKeratitisSwitch: UISwitch!
    @IBOutlet weak var micoticaSwitch: UISwitch!
    @IBOutlet weak var keratoglobusSwitch: UISwitch!
    @IBOutlet weak var cornealDescemetoceleSwitch: UISwitch!
    @IBOutlet weak var pmDegenerationSwitch: UISwitch!
    @IBOutlet weak var cornealBurnsSwitch: UISwitch!
    @IBOutlet weak var atalamiaSwitch: UISwitch!
    @IBOutlet weak var pemphigodSwitch: UISwitch!
    @IBOutlet weak var keratitisSiccaSwitch: UISwitch!
    @IBOutlet weak var keratoconusSwitch: UISwitch!
    @IBOutlet weak var bollousKeratophatySwitch: UISwitch!
    @IBOutlet weak var vascularizedLeukomaSwitch: UISwitch!
    @IBOutlet weak var fuchsDystrophySwitch: UISwitch!
    @IBOutlet weak var interstitialKeratitisSwitch: UISwitch!
    @IBOutlet weak var granularDystrophySwitch: UISwitch!
    @IBOutlet weak var syndromeLESwitch: UISwitch!
    @IBOutlet weak var bloodCompatibilitySwitch: UISwitch!
    @IBOutlet weak var ophthalmicComorbiditiesSwitch: UISwitch!
    @IBOutlet weak var postsurgicalComplicationSwitch: UISwitch!
    @IBOutlet weak var congenitalGlaucomaSwitch: UISwitch!
    @IBOutlet weak var atlSwitch: UISwitch!
    @IBOutlet weak var dmSwitch: UISwitch!
    @IBOutlet weak var itasSwitch: UISwitch!
    
    
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        resetBasicData()
        resetRiskValues()
        resetComorbiditiesValues()
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        if (checkValues() == true) {
            setValuesToPatient()
            performSegue(withIdentifier: "resultsSegue", sender: nil)
        }else {
            //Lanzar alerta
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        ageTextField.text = "23"
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FormTableViewController: setValuesCalculator {
    func resetBasicData() {
        ageTextField.text = ""
        ageTextField.placeholder = "Age must be between 1 - 99"
        sexControl.selectedSegmentIndex = 0
        sizeGraftControl.selectedSegmentIndex = 0
        timeSurgicalControl.selectedSegmentIndex = 0
    }
    func resetRiskValues() {
        herpeticLeukomaSwitch.setOn(false, animated: false)
        perforatedUlcersSwitch.setOn(false, animated: false)
        syndromeSJSwitch.setOn(false, animated: false)
        rejectionSwitch.setOn(false, animated: false)
        bacterialKeratitisSwitch.setOn(false, animated: false)
        retrasplantSwitch.setOn(false, animated: false)
        neurotrophicKeratitisSwitch.setOn(false, animated: false)
        micoticaSwitch.setOn(false, animated: false)
        keratoglobusSwitch.setOn(false, animated: false)
        cornealDescemetoceleSwitch.setOn(false, animated: false)
        pmDegenerationSwitch.setOn(false, animated: false)
        cornealBurnsSwitch.setOn(false, animated: false)
        atalamiaSwitch.setOn(false, animated: false)
        pemphigodSwitch.setOn(false, animated: false)
        keratitisSiccaSwitch.setOn(false, animated: false)
        keratoconusSwitch.setOn(false, animated: false)
        bollousKeratophatySwitch.setOn(false, animated: false)
        vascularizedLeukomaSwitch.setOn(false, animated: false)
        fuchsDystrophySwitch.setOn(false, animated: false)
        interstitialKeratitisSwitch.setOn(false, animated: false)
        granularDystrophySwitch.setOn(false, animated: false)
        syndromeLESwitch.setOn(false, animated: false)
        bloodCompatibilitySwitch.setOn(false, animated: false)
        ophthalmicComorbiditiesSwitch.setOn(false, animated: false)
        postsurgicalComplicationSwitch.setOn(false, animated: false)
        congenitalGlaucomaSwitch.setOn(false, animated: false)
    }
    func resetComorbiditiesValues() {
        atlSwitch.setOn(false, animated: false)
        dmSwitch.setOn(false, animated: false)
        itasSwitch.setOn(false, animated: false)
    }
    func isInt(_ str: String) -> Bool {
        return Int(str) != nil
    }
    
    func checkValues() -> Bool {
        if (ageTextField.text?.isEmpty == false && isInt(String(ageTextField.text!)) == true) {
            if (Int(ageTextField.text!)! > 0 && Int(ageTextField.text!)! < 100) {
                return true
            }else {
                return false
            }
        }else {
            return false
        }
    }
    func countTrue(_ array: [Bool]) -> Int {
        var count: Int = 0
        for element in array {
            if element == true {
                count += count
            }
        }
        return count
    }
    func setGroupRisk() -> Int {
        var low: Int = 0
        var high: Int = 0
        var lowSymptoms: [Bool]
        var highSymptoms: [Bool]
        
        lowSymptoms = [keratoconusSwitch.isOn,bollousKeratophatySwitch.isOn,vascularizedLeukomaSwitch.isOn,fuchsDystrophySwitch.isOn,interstitialKeratitisSwitch.isOn,granularDystrophySwitch.isOn,syndromeLESwitch.isOn]
        highSymptoms = [perforatedUlcersSwitch.isOn,syndromeSJSwitch.isOn,rejectionSwitch.isOn,retrasplantSwitch.isOn,bacterialKeratitisSwitch.isOn,micoticaSwitch.isOn,neurotrophicKeratitisSwitch.isOn,keratoglobusSwitch.isOn,cornealDescemetoceleSwitch.isOn,pmDegenerationSwitch.isOn,keratitisSiccaSwitch.isOn,atalamiaSwitch.isOn,pemphigodSwitch.isOn,cornealBurnsSwitch.isOn,congenitalGlaucomaSwitch.isOn]
        
        low = countTrue(lowSymptoms)
        high = countTrue(highSymptoms)
        
        if (herpeticLeukomaSwitch.isOn == true) {
            high += 1
        }else {
            low += 1
        }
        
        if (high > low) {
            return 1
        }else {
            return 0
        }
    }
    func setSystematicComorbidities() -> Int {
        if (atlSwitch.isOn || dmSwitch.isOn || itasSwitch.isOn) {
            return 1
        }else {
            return 0
        }
    }
    func setValuesToPatient() {
        var patient = Patient()
        
        patient.age = Int(ageTextField.text!)!
        patient.sex = sexControl.selectedSegmentIndex
        patient.graftSize = sizeGraftControl.selectedSegmentIndex
        patient.typeOfTransplant = typeTransplantControl.selectedSegmentIndex
        patient.surgicalTime = timeSurgicalControl.selectedSegmentIndex
        patient.bloodCompatibility = bloodCompatibilitySwitch.isOn
        patient.ophthalmicComorbidities = ophthalmicComorbiditiesSwitch.isOn
        patient.postsurgicalComplications = postsurgicalComplicationSwitch.isOn
        patient.groupRisk = setGroupRisk()
        patient.systematicComorbidities = setSystematicComorbidities()
    }
}
