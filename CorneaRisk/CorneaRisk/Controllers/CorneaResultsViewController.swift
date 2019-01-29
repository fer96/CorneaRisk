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
    
    static var variable: Variable?
    //var result: Double = Ecuations.corneaRisk()
    var result = corneaRisk()
    var centerRL: CGPoint = CGPoint(x: 0,y: 0)
    
    @IBOutlet weak var resultPorcentLabel: UILabel!
    @IBOutlet weak var warningSingsLabel: UILabel!
    @IBOutlet weak var warningTextView: UITextView!
    @IBOutlet weak var translucentView: UIView!
    @IBOutlet weak var greenPorcentView: UIView!
    @IBOutlet weak var redPorcentView: UIView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        warningTextView.isEditable = false
        timerAnimate()
        hideKeyboardWhenTappedAround()
        autoResizeScrollView()
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

}

extension CorneaResultsViewController: Ecuations {
    static func corneaRisk() -> Double {
        //age,sex,groupRisk,bloodC..,ophtal..,sysComor..,post..,gSize,typeT..,surgTiem
        let age = Double(variable!.age) * 0.075
        let sex = Double(variable!.sex) * 0.06
        let gr = Double(variable!.groupRisk) * 0.215
        let bc = Double(variable!.bloodCompatibility) * 0.12
        let oc = Double(variable!.ophthalmicComorbidities) * 0.11
        let sc = Double(variable!.systematicComorbidities) * 0.06
        let pc = Double(variable!.postsurgicalComplications) * 0.14
        let gs = Double(variable!.typeOfTransplant) * 0.09
        let st = Double(variable!.surgicalTime) * 0.13
        
        return (age + sex + gr + bc + oc + sc + pc + gs + st) * 100
    }
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
        if (result > 50.0){
            warningSingsLabel.isHidden = true
            warningSingsLabel.isEnabled = false
            warningSingsLabel.text = ""
            warningTextView.isSelectable = false
            warningTextView.isEditable = false
            warningTextView.isHidden = true
        }else {
            warningSingsLabel.text = "Warning sings"
            warningTextView.isEditable = true
            warningTextView.isSelectable = true
            warningTextView.isHidden = false
        }
    }
    func porcentResult() {
        resultPorcentLabel.text = String(format: "%.2f",result) + " %"
        showWarnigs(result: result)
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
