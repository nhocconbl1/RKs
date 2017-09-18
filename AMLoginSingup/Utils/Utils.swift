//
//  Utils.swift
//  AMLoginSingup
//
//  Created by allgrowlabo on 9/15/17.
//  Copyright © 2017 amirs.eu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
    class func ButtonColor() -> UIColor {
        return UIColor.init(rgb: 0xC471F4, a: 1)
    }
}

