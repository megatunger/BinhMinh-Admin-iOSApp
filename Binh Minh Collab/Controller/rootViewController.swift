//
//  HomeVC.swift
//  Autologin-Swift4
//
//  Created by Aman Aggarwal on 02/03/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit

class rootViewController: UIViewController {

    var window: UIWindow?
    @IBOutlet weak var manualCheckInButton: UIButton!
    @IBOutlet weak var CheckInButton: UIButton!
    @IBOutlet weak var SignOutButton: UIButton!
    @IBOutlet weak var reviewCheckInButton: UIButton!
    
    @IBAction func CheckInStart(_ sender: Any) {
        let ScanViewController = rootScanView()
        self.navigationController?.pushViewController(ScanViewController, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAvailableOptions()
        Style()
    }

    @IBAction func logoutUser(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAvailableOptions() {
        self.checkPermissions(permission_key: "bm_admin_checkin", completion: {(available) in
            if !(available) {
                self.CheckInButton.isHidden = true
                self.reviewCheckInButton.isHidden = true
                self.manualCheckInButton.isHidden = true
            } else{
                self.CheckInButton.isHidden = false
                self.reviewCheckInButton.isHidden = false
                self.manualCheckInButton.isHidden = false
            }
        })
    }
    
}

extension UIViewController {
    func checkPermissions(permission_key: String, completion: @escaping (_ result: Bool) -> Void) {
        Constant.hud.show(in: self.view)
        Constant.APIManager.getAccessPermission(completion: {(data, error) in
            Constant.hud.dismiss(animated: true)
            if (data?.accountType=="super_admin") {
                completion(true)
            } else {
                for permission in data?.permissions ?? [] {
                    if permission.key == permission_key {
                        if permission.value == true {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                }
            }
        })
    }
}
