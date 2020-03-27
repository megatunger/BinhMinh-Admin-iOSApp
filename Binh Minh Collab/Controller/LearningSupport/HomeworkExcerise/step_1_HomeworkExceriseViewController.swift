//
//  step_1_HomeworkExceriseViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 3/25/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class step_1_HomeworkExceriseViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        ButtonStyle()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func ButtonStyle() {
        nextButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        nextButton.layer.borderWidth = 0
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
