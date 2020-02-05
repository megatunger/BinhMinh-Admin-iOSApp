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
            Constant.hud.show(in: self.view)
            
            APIManager.manualCheckinSubmitData(
                student_id: self.params.student_id ?? 0,
                classroom_id: self.params.classroom_id ?? 0,
                event_id: self.params.event_id ?? 0,
                completion: {(data, error) in
                    Constant.hud.dismiss(afterDelay: 1.0)
                    switch data?.status {
                        case "failed":
                            let alert = UIAlertController(title: "Có lỗi xảy ra", message: data?.errorExplain, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                                self.navigationController?.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        case "warning":
                            let alert = UIAlertController(title: "Thông báo", message: data?.errorExplain, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
                                self.performSegue(withIdentifier: "finished", sender: self)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        case "success":
                            self.performSegue(withIdentifier: "finished", sender: self)
                        case .none:
                            break
                        case .some(_):
                            break
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
