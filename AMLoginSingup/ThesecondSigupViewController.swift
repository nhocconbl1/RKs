//
//  ThesecondSigupViewController.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/19/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import TextFieldEffects
class ThesecondSigupViewController: UIViewController,SCPopDatePickerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var BirthdayTextView: HoshiTextField!
    @IBOutlet weak var SexTextView: HoshiTextField!
    
    
    let datePicker = SCPopDatePicker()
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI(){
        self.datePicker.tapToDismiss = true
        self.datePicker.datePickerType = SCDatePickerType.date
        self.datePicker.showBlur = true
    
        self.datePicker.btnFontColour = UIColor.white
        self.datePicker.btnColour = UIColor.ButtonColor()
        self.datePicker.showCornerRadius = false
        self.datePicker.delegate = self
        self.BirthdayTextView.delegate = self
        self.SexTextView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scPopDatePickerDidSelectDate(_ date: Date) {
        self.date = date
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd"
        
        let myString = formatter.string(from: self.date)
        
        self.BirthdayTextView.text = myString
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.BirthdayTextView {
                self.datePicker.datePickerStartDate = self.date
                self.datePicker.show(attachToView: self.view)
            
        }else{
            print("Male")
        }
    
        
        return false
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
