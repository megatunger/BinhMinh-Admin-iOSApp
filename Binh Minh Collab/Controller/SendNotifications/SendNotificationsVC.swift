//
//  SendNotificationsVC.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/7/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class SendNotificationsVC: UIViewController {
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var classroomButton: UIButton!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAvailableOptions()
        Style()
    }
    
    
    func checkAvailableOptions() {
        self.checkPermissions(permission_key: "bm_admin_notifications", completion: {(available) in
            if !(available) {
                self.studentButton.isHidden = true
                self.classroomButton.isHidden = true
                self.eventButton.isHidden = true
                self.allButton.isHidden = true
            } else {
                self.studentButton.isHidden = false
                self.classroomButton.isHidden = false
                self.eventButton.isHidden = false
                self.allButton.isHidden = false
            }
        })
    }
}


extension SendNotificationsVC {
    
    func Style() {
        studentButtonButtonStyle()
        classroomButtonButtonStyle()
        eventButtonButtonStyle()
        allButtonButtonStyle()
    }
    
    private func studentButtonButtonStyle() {
        studentButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        studentButton.layer.borderWidth = 0
    }
    
    private func classroomButtonButtonStyle() {
        classroomButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        classroomButton.layer.borderWidth = 0
    }
    
    private func eventButtonButtonStyle() {
        eventButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        eventButton.layer.borderWidth = 0
    }
    
    private func allButtonButtonStyle() {
        allButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        allButton.layer.borderWidth = 0
    }
}
