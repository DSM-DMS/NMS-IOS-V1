//
//  TextField.swift
//  NMS-IOS
//
//  Created by 김대희 on 2021/11/08.
//

import Foundation
import UIKit

extension UITextField {
    func setUnderLine(color : UIColor) {
            let border = CALayer()
            let width = CGFloat(0.5)
            border.borderColor = color.cgColor
        border.frame = CGRect(x: 0.0, y: self.frame.size.height + 3, width:  self.frame.size.width, height: 1)
        // x: 0.0, y: emailTextField.frame.height + 3, width: emailTextField.frame.width + 8, height: 1
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = false
        }

}
