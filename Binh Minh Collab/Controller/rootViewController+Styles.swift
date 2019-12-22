//
//  rootViewController+Styles.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/14/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

extension rootViewController {
    
    func Style() {
        CheckInButtonStyle()
        SignOutButtonStyle()
        ReviewCheckInButtonStyle()
        ManualCheckInButtonStyle()
    }
    
    private func CheckInButtonStyle() {
        CheckInButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        CheckInButton.layer.borderWidth = 0
    }
    
    private func SignOutButtonStyle() {
        SignOutButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        SignOutButton.layer.borderWidth = 0
    }
    
    private func ReviewCheckInButtonStyle() {
        reviewCheckInButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        reviewCheckInButton.layer.borderWidth = 0
    }
    
    private func ManualCheckInButtonStyle() {
        manualCheckInButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        manualCheckInButton.layer.borderWidth = 0
    }
}
