//
//  ChangepasswordViewController.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/20/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftValidator
class ChangepasswordViewController: UIViewController {

    @IBOutlet weak var OldpasswordTextView: HoshiTextField!
    @IBOutlet weak var NewpasswordTextView: HoshiTextField!
    @IBOutlet weak var ComfirmpasswordTextView: HoshiTextField!
    @IBOutlet weak var ChangeButton: UIButton!
    @IBOutlet weak var BottomButtonContrain: NSLayoutConstraint!
    @IBOutlet weak var OldPwdLabel: UILabel!
    @IBOutlet weak var NewPwdLabel: UILabel!
    @IBOutlet weak var ConfirmPwdLabel: UILabel!
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
      setupValidator()
        self.ChangeButton.addTarget(self, action: #selector(ChangeAction(_:)), for: .touchUpInside)
    }
    func ChangeAction(_ button:UIButton){
        self.validator.validate(self)
    }
    func setupValidator(){
        self.validator.styleTransformers(success:{ (validationRule) -> Void in
         
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
        }, error:{ (validationError) -> Void in
      
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
         
        })
        self.validator.registerField(OldpasswordTextView, errorLabel: OldPwdLabel, rules: [RequiredRule(), MinLengthRule.init(length: 8, message: "Minimum 8 characters"),MaxLengthRule(length:32,message:"Maximum 32 characters")])
        self.validator.registerField(NewpasswordTextView, errorLabel: NewPwdLabel, rules: [RequiredRule(), MinLengthRule.init(length: 8, message: "Minimum 8 characters"),MaxLengthRule(length:32,message:"Maximum 32 characters")])
        self.validator.registerField(ComfirmpasswordTextView, errorLabel: ConfirmPwdLabel, rules:[ConfirmationRule(confirmField: NewpasswordTextView,message:"Confirm password is incorrect")])
    
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
        
        
//        PickerViewHeightContrain.constant = keyboardShow ? 100 : 0
        BottomButtonContrain.constant = keyboardShow ? (hideLogo ? 0:(self.view.frame.size.height - topOfKetboard)):20
        
        // animate constraints changes
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        
        self.view.layoutIfNeeded()
        
        UIView.commitAnimations()
        
    }
    
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
extension ChangepasswordViewController:ValidationDelegate{
    
    func validationSuccessful() {
        

    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        
    }
}

