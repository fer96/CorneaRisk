//
//  CorneaResultsViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit

class CorneaResultsViewController: UIViewController {

    
    @IBOutlet weak var resultPorcentLabel: UILabel!
    @IBOutlet weak var warningSingsLabel: UILabel!
    @IBOutlet weak var warningTextView: UITextView!
    
    
    func showWarnigs(result: Double) {
        if (result > 50.00){
            warningSingsLabel.isHidden = false
            warningSingsLabel.isEnabled = false
            warningTextView.isSelectable = false
            warningTextView.isEditable = false
            warningTextView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ResultPorcentView.resultPorcent = Ecuations.corneaRisk()
        resultPorcentLabel.text = String(format: "%.2f", ResultPorcentView.resultPorcent) + " %"
        showWarnigs(result: ResultPorcentView.resultPorcent)
        
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
