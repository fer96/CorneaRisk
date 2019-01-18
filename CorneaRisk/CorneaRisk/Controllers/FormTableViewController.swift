//
//  FormTableViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/18/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class FormTableViewController: UITableViewController {
    
    var patient = Patient()
    
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
    @IBOutlet weak var atlSwitch: UISwitch!
    @IBOutlet weak var dmSwitch: UISwitch!
    @IBOutlet weak var itasSwitch: UISwitch!
    
    
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
    }
    
    func resetValues() {
        ageTextField.text = ""
        ageTextField.placeholder = "Age must be between 0 - 99"
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
