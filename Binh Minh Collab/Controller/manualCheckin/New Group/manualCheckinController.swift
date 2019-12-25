//
//  manualCheckinController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/8/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
class manualCheckin: UIViewController {
    @IBOutlet weak var nextStep1: UIButton!
    @IBOutlet weak var idField: UITextField!
    
    var params = manualCheckinResponseParams.init(student_id: nil, classroom_id: nil, event_id: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func nextStepTap(_ sender: Any) {
        if idField.text!.isEmpty {
            let alert = UIAlertController(title: "Vui lòng nhập ID", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.params.student_id = Int(idField.text!)
            self.performSegue(withIdentifier: "step_1", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "step_1" {
            let classroomSelectVC = segue.destination as? step_2_MC
            if let csVC = classroomSelectVC {
                csVC.params = self.params
            }
        }
    }
}

