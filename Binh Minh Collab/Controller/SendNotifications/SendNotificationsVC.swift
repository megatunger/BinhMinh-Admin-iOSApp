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
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
