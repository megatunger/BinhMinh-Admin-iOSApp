//
//  LearningSupportViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 3/25/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class LearningSupportViewController: UIViewController {
    @IBOutlet weak var HomeworkButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAvailableOptions()
        ButtonStyle()
    }

    private func ButtonStyle() {
        HomeworkButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        HomeworkButton.layer.borderWidth = 0
    }
    
    
    func checkAvailableOptions() {
        self.checkPermissions(permission_key: "bm_admin_learning_support", completion: {(available) in
            if !(available) {
                self.HomeworkButton.isHidden = true
            } else {
                self.HomeworkButton.isHidden = false
            }
        })
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
