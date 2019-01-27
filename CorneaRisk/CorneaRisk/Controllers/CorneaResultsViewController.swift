//
//  CorneaResultsViewController.swift
//  CorneaRisk
//
//  Created by Fernando De La Rosa on 1/9/19.
//  Copyright © 2019 Fernando De La Rosa. All rights reserved.
//

import UIKit


protocol setResult {
    func timerAnimate()
    func showWarnigs(result: Double)
    func porcentResult()
}

class CorneaResultsViewController: UIViewController {
    
    var result: Double = Ecuations.corneaRisk()
    var centerRL: CGPoint = CGPoint(x: 0,y: 0)
    
    @IBOutlet weak var resultPorcentLabel: UILabel!
    @IBOutlet weak var warningSingsLabel: UILabel!
    @IBOutlet weak var warningTextView: UITextView!
    @IBOutlet weak var translucentView: UIView!
    @IBOutlet weak var greenPorcentView: UIView!
    @IBOutlet weak var redPorcentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerAnimate()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.autoreverse,.repeat], animations: {
            self.translucentView.center.y += self.translucentView.bounds.height
        }, completion: nil)
        //resultPorcentLabel.center.x -= (resultPorcentLabel.center.x * 2) - (greenPorcentView.bounds.width * CGFloat((100 - self.result)  * 0.01))
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
    func timerAnimate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.225){
            self.translucentView.layer.removeAllAnimations()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.translucentView.center.y -= self.translucentView.bounds.height * CGFloat(self.result * 0.01)
                }, completion: nil)
                UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn], animations: {
                    //self.greenPorcentView.center.x -= self.greenPorcentView.bounds.width * CGFloat((100.0 - self.result)  * 0.01)
                    self.greenPorcentView.center.x += self.greenPorcentView.bounds.width * CGFloat((self.result)  * 0.01)
                }, completion: nil)
                UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.resultPorcentLabel.center.x -= (self.resultPorcentLabel.center.x * 2) - (self.greenPorcentView.bounds.width * CGFloat((100 - self.result)  * 0.01))
                }, completion: nil)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.porcentResult()
            }
        }
    }
    func showWarnigs(result: Double) {
        if (result > 50.00){
            warningSingsLabel.isHidden = false
            warningSingsLabel.isEnabled = false
            warningSingsLabel.text = ""
            warningTextView.isSelectable = false
            warningTextView.isEditable = false
            warningTextView.isHidden = false
        }else {
            warningSingsLabel.text = "Warning sings"
        }
    }
    func porcentResult() {
        resultPorcentLabel.text = String(format: "%.2f",result) + " %"
        showWarnigs(result: result)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SavePatientViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
