//
//  manualCheckin + Styles.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/8/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
extension manualCheckin {
    func Style() {
        nextStep_1_Style()
        idFieldStyle()
    }

    private func nextStep_1_Style() {
        nextStep1.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        nextStep1.layer.borderWidth = 0
    }

    private func idFieldStyle() {
        idField.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        idField.layer.borderWidth = 0
        addPaddingAndBorder(to: idField)
    }
    
    private func addPaddingAndBorder(to textfield: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

