//
//  finished_MC.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/8/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

class finished_MC: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
    }
    
    @IBAction func finishTouch(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
}

extension finished_MC {
    
    func Style() {
        closeButton_Style()
    }

    private func closeButton_Style() {
        closeButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        closeButton.layer.borderWidth = 0
    }
}
