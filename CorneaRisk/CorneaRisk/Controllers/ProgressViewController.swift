//
//  ProgressViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/23/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var patient: Patient?
    var appoiments = [Appointment]()
    let date = Date()
    
    
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
        cell.dateLabel.text = date.string(with: "dd/MM/YYYY")
        cell.vaTextField.text = appoiment.visualAcuity
        cell.transplantSwitch.setOn(appoiment.transplant, animated: false)
        cell.complicationsTextView.text = appoiment.complications
        cell.delegate = self as? AppoimentCellDelegate
        
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

extension Date {
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
