//
//  ResetPasswordViewController.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/14/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import SwiftValidator
class ResetPasswordViewController: UIViewController {
        @IBOutlet var EmailTextView: AMInputView!
   @IBOutlet weak var loginButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backImageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var resetButton:UIButton!
     let animationDuration = 0.25
    
    let validator = Validator() //Reset
    override func viewDidLoad() {
        super.viewDidLoad()
        ValidatorInit()
   NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        self.resetButton.addTarget(self, action: #selector(ResetPasswordAction(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    func ValidatorInit()  {
        self.validator.registerField(EmailTextView.textFieldView, errorLabel: EmailTextView.labelView, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
    
    }
    func ResetPasswordAction(_ button:UIButton) {
        self.validator.validate(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func keyboarFrameChange(notification:NSNotification){
        
        let userInfo = notification.userInfo as! [String:AnyObject]
        
        // get top of keyboard in view
        let topOfKetboard = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue .origin.y
        
        
        // get animation curve for animate view like keyboard animation
        var animationDuration:TimeInterval = 0.25
        var animationCurve:UIViewAnimationCurve = .easeOut
        if let animDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
            animationDuration = animDuration.doubleValue
        }
        
        if let animCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
            animationCurve =  UIViewAnimationCurve.init(rawValue: animCurve.intValue)!
        }
        
        
        // check keyboard is showing
        let keyboardShow = topOfKetboard != self.view.frame.size.height
        
        
        //hide logo in little devices
        let hideLogo = self.view.frame.size.height < 667
        
        // set constraints
        backImageBottomConstraint.constant = self.view.frame.size.height - topOfKetboard
        
        logoTopConstraint.constant = keyboardShow ? (hideLogo ? 0:20):50
        logoHeightConstraint.constant = keyboardShow ? (hideLogo ? 0:60):90
        logoBottomConstraint.constant = keyboardShow ? 32:60
      
        

        
        loginButtonTopConstraint.constant = keyboardShow ? 32:60
       
        
        resetButton.alpha = keyboardShow ? 1:0.7
        
        
        
        
        // animate constraints changes
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
        
    }
    
    //MARK: - hide status bar in swift3
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ResetPasswordViewController:ValidationDelegate{
    
    func validationSuccessful() {
        // submit the form
            self.EmailTextView.SetupLabel(error: false)
          
            NSLog("Email:\(EmailTextView.textFieldView.text)")
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            
            error.errorLabel?.textColor = UIColor.red
            error.errorLabel?.text = error.errorMessage // works if you added labels
            //            error.errorLabel?.isHidden = false
        }
    }
}

