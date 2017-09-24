//
//  ThesecondSigupViewController.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/19/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit
import TextFieldEffects
import CZPicker

class ThesecondSigupViewController: UIViewController,SCPopDatePickerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var BirthdayTextView: HoshiTextField!
    @IBOutlet weak var SexTextView: HoshiTextField!
    
    @IBOutlet weak var FinishButton: UIButton!
    
    let datePicker = SCPopDatePicker()
    var date = Date()
    var genders = ["Male","Femade","LGBT","Orther"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI(){
        FinishButton.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        FinishButton.layer.shadowRadius = 10.0
        FinishButton.layer.shadowColor = UIColor.init(rgb: 0xC471F4, a: 0.5).cgColor
        FinishButton.layer.shadowOpacity = 1.0
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
        formatter.dateFormat = "MM-dd-yyyy"
        
        let myString = formatter.string(from: self.date)
        
        self.BirthdayTextView.text = myString
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.BirthdayTextView {
                self.datePicker.datePickerStartDate = self.date
                self.datePicker.show(attachToView: self.view)
            
        }else{
            let picker = CZPickerView(headerTitle: "Gender", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
                picker?.delegate = self
                picker?.dataSource = self
                picker?.needFooterView = false
                picker?.headerBackgroundColor = UIColor.ButtonColor()
                picker?.show()
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
extension ThesecondSigupViewController: CZPickerViewDelegate, CZPickerViewDataSource {
    
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
        SexTextView.text = self.genders[row]
    }
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
           self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
  
}
