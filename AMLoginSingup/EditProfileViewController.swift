//
//  EditProfileViewController.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/20/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import TextFieldEffects
import SnapKit
import NVActivityIndicatorView
import SwiftValidator
import CZPicker
class EditProfileViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var UsernameTextView: HoshiTextField!
    @IBOutlet weak var CheckView: UIView!
    @IBOutlet weak var CheckLabel: UILabel!
    @IBOutlet weak var BirthdayTextView: HoshiTextField!
    @IBOutlet weak var GenderTextView: HoshiTextField!
    @IBOutlet weak var BottomButtonContrain: NSLayoutConstraint!
    
    @IBOutlet weak var LabelHeightContrain: NSLayoutConstraint!
    @IBOutlet weak var UploadButton: UIButton!
    let validator = Validator()
    var work:DispatchWorkItem?
    var activityIndicatorView:NVActivityIndicatorView?
    let datePicker = SCPopDatePicker()
    var date = Date()
    var genders = ["Male","Femade","LGBT","Orther"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //        UserNameView.labelView.textColor = .black
        NotificationCenter.default.addObserver(self, selector: #selector(keyboarFrameChange(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        UsernameTextView.addTarget(self, action: #selector(CheckUsername(_:)), for: .editingChanged)
        self.validator.registerField(UsernameTextView, rules: [RegexRule.init(regex: "^(?=\\S{8})[a-zA-Z]\\w*(?:\\.\\w+)*(?:@\\w+\\.\\w{2,4})?$",message:"Username Invalid ")])

    }
    func setupUI(){
        UploadButton.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        UploadButton.layer.shadowRadius = 10.0
        UploadButton.layer.shadowColor = UIColor.init(rgb: 0xC471F4, a: 0.5).cgColor
        UploadButton.layer.shadowOpacity = 1.0
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
        //Birthday picker 
        self.datePicker.tapToDismiss = true
        self.datePicker.datePickerType = SCDatePickerType.date
        self.datePicker.showBlur = true
        
        self.datePicker.btnFontColour = UIColor.white
        self.datePicker.btnColour = UIColor.ButtonColor()
        self.datePicker.showCornerRadius = false
        self.datePicker.delegate = self
        self.BirthdayTextView.delegate = self
        self.GenderTextView.delegate = self
        
        
        
    }
    
    
    func CheckUsername(_ textField: UITextField) {
        validator.validateField(textField){ error in
            self.work?.cancel()
        
            if error == nil {
                self.activityIndicatorView!.startAnimating()
                self.CheckLabel.text = "Checking..."
                self.work = DispatchWorkItem.init(block: {
                    self.activityIndicatorView!.stopAnimating()
                    self.CheckLabel.text = "Username valid"
                    self.AnalyzeCheckUser()
                })
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: self.work!)
            } else {
                self.CheckLabel.text = error?.errorMessage
                self.activityIndicatorView!.stopAnimating()
                
            }
        }
        
        
    }
    
    
    func AnalyzeCheckUser()  {
        print("\(String(describing: self.UsernameTextView.text))")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == self.BirthdayTextView {
            self.datePicker.datePickerStartDate = self.date
            self.datePicker.show(attachToView: self.view)
            
        }else if textField == self.GenderTextView{
            let picker = CZPickerView(headerTitle: "Gender", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
            picker?.delegate = self
            picker?.dataSource = self
            picker?.needFooterView = false
            picker?.headerBackgroundColor = UIColor.ButtonColor()
            picker?.show()
        }
        
        
        return false
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
        
        
        LabelHeightContrain.constant = keyboardShow ? 50 : 100
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
extension EditProfileViewController:SCPopDatePickerDelegate{
    func scPopDatePickerDidSelectDate(_ date: Date) {
        self.date = date
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "MM-dd-yyyy"
        
        let myString = formatter.string(from: self.date)
        
        self.BirthdayTextView.text = myString
    }
}
extension EditProfileViewController: CZPickerViewDelegate, CZPickerViewDataSource {
    
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        return nil
    }
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return self.genders.count
    }
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return self.genders[row]
    }
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        self.GenderTextView.text = self.genders[row]
    }
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
