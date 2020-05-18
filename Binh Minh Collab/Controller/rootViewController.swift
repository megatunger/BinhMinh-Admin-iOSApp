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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
