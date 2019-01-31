//
//  GraphViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/30/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit
import Charts

protocol Graph {
    func setValues(_ from: [Appointment])
    func setGraph()
}

class GraphViewController: UIViewController {
    
    static var patient: Patient?
    static var appointments: [Appointment]?
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ssnLabel: UILabel!
    @IBOutlet weak var crrLabel: UILabel!
    
    //MARK: Graph
    var vaArray = [Double]()
    @IBOutlet weak var graphView: LineChartView!
    let thirdColor = NSUIColor(displayP3Red: CGFloat(0.388), green: CGFloat(0.604), blue: CGFloat(0.404), alpha: CGFloat(1))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameLabel.text = (GraphViewController.patient?.lastName)! + " " + (GraphViewController.patient?.secondLastName)! + " " + (GraphViewController.patient?.name)!
        ssnLabel.text = "SSN: " + (GraphViewController.patient?.socialSecurityNumber)!
        crrLabel.text = "CRR: " + (GraphViewController.patient?.resultCRC)!
        
        //MARK: Set graph
        setValues(GraphViewController.appointments ?? [])
        setGraph()
        
    }
    
}

extension GraphViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (GraphViewController.appointments?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = GraphViewController.appointments![indexPath.row]
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Datum")
        cell.textLabel?.text = "Date: " + appointment.date.string(with: "dd/MM/YYYY")
        if !appointment.visualAcuity.isEmpty {
            cell.detailTextLabel?.text = "VA: 20 / " + appointment.visualAcuity
        }else { cell.detailTextLabel?.text = "" }
        cell.detailTextLabel?.textColor = UIColor.black
        
        return cell
    }
}

extension GraphViewController: Graph {
    func isInt(_ str: String) -> Bool {
        return Int(str) != nil
    }
    func setValues(_ from: [Appointment]) {
        for appointment in from{
            if isInt(appointment.visualAcuity){
                vaArray.append(Double(appointment.visualAcuity)!)
            }
        }
    }
    func setGraph(){
        var lineChartEntry  = [ChartDataEntry]()
    
        for i in 0..<vaArray.count {
            let value = ChartDataEntry(x: Double(i), y: vaArray[i])
            lineChartEntry.append(value)
        }
        
        let line = LineChartDataSet(values: lineChartEntry, label: "Visual Acuity")
        line.colors = [thirdColor]
        line.circleColors = [thirdColor]
        
        let data = LineChartData()
        data.addDataSet(line)
        
        graphView.data = data
        graphView.chartDescription?.text = "Corneal Rejection Calculator"
    }

}

