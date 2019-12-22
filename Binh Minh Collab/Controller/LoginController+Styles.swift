//
//  LoginController+Styles.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/12/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

let LOGO_HEIGHT_MIN = CGFloat(80)
let LOGO_HEIGHT_MAX = CGFloat(250)

extension LoginController {
    
    func Style() {
        LogoStyle()
        ButtonStyle()
        EmailStyle()
        PasswordStyle()
    }
    
    private func ButtonStyle() {
        LoginButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        LoginButton.layer.borderWidth = 0
    }
    
    private func LogoStyle() {
        LogoHeight.constant = CGFloat(LOGO_HEIGHT_MAX)
        LoginView.layoutIfNeeded()
    }
    
    private func EmailStyle() {
        EmailField.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        EmailField.layer.borderWidth = 0
        addPaddingAndBorder(to: EmailField)
    }
    
    private func PasswordStyle() {
        PasswordField.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        PasswordField.layer.borderWidth = 0
        addPaddingAndBorder(to: PasswordField)
    }
    
    private func addPaddingAndBorder(to textfield: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
    
    // Animation resize logo when show up keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        LogoHeight.constant = LOGO_HEIGHT_MIN
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveEaseInOut, //Use ease-in, ease-out timing.
            animations:  {
                self.view.layoutIfNeeded()
        },
            completion: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        LogoHeight.constant = LOGO_HEIGHT_MAX
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveEaseInOut, //Use ease-in, ease-out timing.
            animations:  {
                self.view.layoutIfNeeded()
        },
            completion: nil)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
