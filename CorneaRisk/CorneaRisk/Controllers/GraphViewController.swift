//
//  GraphViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/30/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    static var patient: Patient?
    static var appointments: [Appointment]?
    
    //MARK: View
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ssnLabel: UILabel!
    @IBOutlet weak var crrLabel: UILabel!
    
    
    //MARK: Graph
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameLabel.text = (GraphViewController.patient?.lastName)! + " " + (GraphViewController.patient?.secondLastName)! + " " + (GraphViewController.patient?.name)!
        ssnLabel.text = "SSN: " + (GraphViewController.patient?.socialSecurityNumber)!
        crrLabel.text = "CRR: " + (GraphViewController.patient?.resultCRC)!
        
    }
    
}

extension GraphViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (GraphViewController.appointments?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = GraphViewController.appointments![indexPath.row]
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Datum")
        cell.textLabel?.text = appointment.date.string(with: "dd/MM/YYYY")
        if !appointment.visualAcuity.isEmpty {
            cell.detailTextLabel?.text = "20 / " + appointment.visualAcuity
        }else { cell.detailTextLabel?.text = "" }
        cell.detailTextLabel?.textColor = UIColor.black
        
        return cell
    }
    
    
}
