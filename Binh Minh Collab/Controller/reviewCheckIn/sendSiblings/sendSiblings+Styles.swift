//
//  sendSiblings+Styles.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/27/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
extension sendSiblings {
    func Style() {
        sendMessageButtonStyle()
        HideSeperator()
    }
    
    private func sendMessageButtonStyle() {
        sendMessageButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        sendMessageButton.layer.borderWidth = 0
    }
    
    private func HideSeperator() {
        self.tableData.separatorColor = UIColor.clear;
    }
}
