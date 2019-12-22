//
//  step_3_MC.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/8/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
class step_3_MC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    let APIManager = BinhMinhAPIManager()
    var class_name_selecting: String = ""
    
    var params = manualCheckinResponseParams.init(student_id: nil, classroom_id: nil, event_id: nil)
    var data = manualCheckinResponse_Classroom.init(class_id: nil, class_name: nil, class_description: nil, lectures: nil)
    var selecting_row: Int = -1
    var selecting_row_2: Int = -1
    let cellReuseIdentifier = "classroomCell"
    
    @IBAction func submit(_ sender: Any) {
        print(params)
        if params.event_id==nil {
            let alert = UIAlertController(title: "Vui lòng chọn ca học", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let hud = JGProgressHUD(style: .dark)
            hud.vibrancyEnabled = true
            hud.textLabel.text = "Đang lưu"
            hud.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)

            hud.show(in: self.view)
            
            APIManager.manualCheckinSubmitData(
                student_id: self.params.student_id ?? 0,
                classroom_id: self.params.classroom_id ?? 0,
                event_id: self.params.event_id ?? 0,
                completion: {(_data, error) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                        UIView.animate(withDuration: 0.3) {
                            hud.indicatorView = nil
                            hud.textLabel.font = UIFont.systemFont(ofSize: 30.0)
                            hud.textLabel.text = _data?.status
                            hud.position = .bottomCenter
                        }
                    }
                    hud.dismiss(afterDelay: 2.0)
                    if (_data?.status == "success") {
                        self.performSegue(withIdentifier: "finished", sender: self)
                    }
                })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
