//
//  ThefirstSignupViewController.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/15/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import UIKit

class ThefirstSignupViewController: UIViewController {

    @IBOutlet weak var UserNameView: AMInputView!
    @IBOutlet weak var NextButton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // make the shadow
        NextButton.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        NextButton.layer.shadowRadius = 10.0
        NextButton.layer.shadowColor = UIColor.init(rgb: 0xC471F4, a: 0.5).cgColor
        NextButton.layer.shadowOpacity = 1.0
     
//        UserNameView.labelView.textColor = .black
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
