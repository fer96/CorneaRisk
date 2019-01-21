//
//  CorneaResultsViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit


protocol setResult {
    func showWarnigs(result: Double)
    func porcentResult()
}

class CorneaResultsViewController: UIViewController {
    
    var result: Double = Ecuations.corneaRisk()
    
    @IBOutlet weak var resultPorcentLabel: UILabel!
    @IBOutlet weak var warningSingsLabel: UILabel!
    @IBOutlet weak var warningTextView: UITextView!
    @IBOutlet weak var translucentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.1){
            self.translucentView.layer.removeAllAnimations()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.translucentView.center.y -= self.translucentView.bounds.height * CGFloat(self.result / 100)
                }, completion: nil)
                self.porcentResult()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.autoreverse,.repeat], animations: {
            self.translucentView.center.y += self.translucentView.bounds.height
        }, completion: nil)
        
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

extension CorneaResultsViewController: setResult {
    func showWarnigs(result: Double) {
        if (result > 50.00){
            warningSingsLabel.isHidden = false
            warningSingsLabel.isEnabled = false
            warningSingsLabel.text = ""
            warningTextView.isSelectable = false
            warningTextView.isEditable = false
            warningTextView.isHidden = false
        }
    }
    func porcentResult() {
        ResultPorcentView.resultPorcent = result
        resultPorcentLabel.text = String(format: "%.2f", ResultPorcentView.resultPorcent) + " %"
        showWarnigs(result: ResultPorcentView.resultPorcent)
    }
}
