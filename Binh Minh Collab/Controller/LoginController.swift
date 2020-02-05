//
//  ViewController.swift
//  Autologin-Swift4
//
//  Created by Aman Aggarwal on 02/03/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit
import JGProgressHUD
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
            Constant.hud.show(in: self.view)
            Constant.APIManager.testConnection(completion: {(data, error) in
                Constant.hud.dismiss(afterDelay: 2.0, animated: true)
                switch data?.status {
                    case "failed":
                        let alert = UIAlertController(title: "Có lỗi xảy ra", message: data?.errorExplain, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                            UserDefaults.standard.removeObject(forKey: "ISUSERLOGGEDIN")
                            UserDefaults.standard.removeObject(forKey: "apiToken")
                        }))
                        self.present(alert, animated: true, completion: nil)
                    case "success":
                        //user is authenticated in just navigate him to home screen
                        self.performSegue(withIdentifier: "authenticateCompleted", sender: nil)
                    case .none:
                        break
                    case .some(_):
                        break
                }
            })
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        
        view.addGestureRecognizer(tap)
        Style()
    }

    @IBAction func authenticateUser(_ sender: Any) {
        Constant.hud.show(in: self.view)
        Constant.APIManager.login(email: txtUserName.text ?? "", password: txtPassword.text ?? "", completion: {(data, error) in
            Constant.hud.dismiss(animated: true)
            switch data?.status {
                case "failed":
                    let alert = UIAlertController(title: "Có lỗi xảy ra", message: data?.errorExplain, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case "success":
                    //navigate to home screen
                    UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                    UserDefaults.standard.set(data?.errorExplain, forKey: "apiToken")
                    let rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootViewController") as! rootViewController
                    self.navigationController?.pushViewController(rootViewController, animated: true)
                case .none:
                    break
                case .some(_):
                    break
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

