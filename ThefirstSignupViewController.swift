//
//  ThefirstSignupViewController.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/15/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import TextFieldEffects
import SnapKit
import NVActivityIndicatorView
import SwiftValidator

class ThefirstSignupViewController: UIViewController {
    
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var UsernameTextView: HoshiTextField!
    @IBOutlet weak var PickerViewHeightContrain: NSLayoutConstraint!
    @IBOutlet weak var BottomNextContrain: NSLayoutConstraint!
    @IBOutlet weak var PickerImageView: UIImageView!
    @IBOutlet weak var CheckView: UIView!
    @IBOutlet weak var CheckLabel: UILabel!
    let validator = Validator()
    // ^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9\.\-_?@]+(?<![_.])$
    
    var activityIndicatorView:NVActivityIndicatorView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // make the shadow
        setupUI()
        //        UserNameView.labelView.textColor = .black
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        UsernameTextView.addTarget(self, action: #selector(CheckUsername(_:)), for: .editingChanged)
        self.validator.registerField(UsernameTextView, rules: [RegexRule.init(regex: "^(?=\\S{8})[a-zA-Z]\\w*(?:\\.\\w+)*(?:@\\w+\\.\\w{2,4})?$",message:"Username Invalid ")])
        
        
    }
    func setupUI(){
        NextButton.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        NextButton.layer.shadowRadius = 10.0
        NextButton.layer.shadowColor = UIColor.init(rgb: 0xC471F4, a: 0.5).cgColor
        NextButton.layer.shadowOpacity = 1.0
        UsernameTextView.returnKeyType = .done
        UsernameTextView.keyboardAppearance = .dark
        
        let hub = UIView()
        self.CheckView.addSubview(hub)
        
        hub.snp.makeConstraints({
            (make) -> Void in
            make.right.equalTo(self.CheckView).offset(0)
            make.centerY.equalTo(self.CheckView)
            make.width.equalTo(25)
            make.height.equalTo(25)
        })
        
        activityIndicatorView =  NVActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20), type: NVActivityIndicatorType.pacman, color: UIColor.ButtonColor() , padding: 20)
        
        hub.addSubview(activityIndicatorView!)
        
    }
    func CheckUsername(_ textField: UITextField) {
        validator.validateField(textField){ error in
            if error == nil {
                self.activityIndicatorView!.startAnimating()
                self.CheckLabel.text = "Checking..."
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
                    
                    self.activityIndicatorView!.stopAnimating()
                     self.CheckLabel.text = "Username valid"
                }
                
            } else {
                self.CheckLabel.text = error?.errorMessage
                self.activityIndicatorView!.stopAnimating()
            }
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        PickerViewHeightContrain.constant = keyboardShow ? 100 : 0
        BottomNextContrain.constant = keyboardShow ? (hideLogo ? 0:(self.view.frame.size.height - topOfKetboard)):20
        
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
