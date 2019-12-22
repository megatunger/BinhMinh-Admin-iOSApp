//
//  resultScreen+Styles.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/24/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

extension resultScreenController {
    func Style() {
        CompleteButtonStyle()
        HideSeperator()
        disableSwipe()
    }
    
    private func CompleteButtonStyle() {
        completeButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        completeButton.layer.borderWidth = 0
    }
    
    private func HideSeperator() {
        self.tableData.separatorColor = UIColor.clear;
    }
    
    private func disableSwipe() {
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true // available in IOS13
        }
    }
    
}
