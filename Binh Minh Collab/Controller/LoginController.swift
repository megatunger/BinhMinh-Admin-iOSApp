//
//  ViewController.swift
//  Autologin-Swift4
//
//  Created by Aman Aggarwal on 02/03/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet var LoginView: UIView!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var LogoHeight: NSLayoutConstraint!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            //user is already logged in just navigate him to home screen
            let rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootViewController") as! rootViewController
            self.navigationController?.pushViewController(rootViewController, animated: false)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        
        view.addGestureRecognizer(tap)
        Style()
    }

    @IBAction func authenticateUser(_ sender: Any) {
        if txtUserName.text == "test" && txtPassword.text == "test" {
            //navigate to home screen
            UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            let rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootViewController") as! rootViewController
            self.navigationController?.pushViewController(rootViewController, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

