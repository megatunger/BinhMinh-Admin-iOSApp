//
//  step_3_MC + Styles.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/10/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit


extension step_3_MC {
    
    func Style() {
        nextStep_Style()
    }

    private func nextStep_Style() {
        nextButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        nextButton.layer.borderWidth = 0
    }
}
