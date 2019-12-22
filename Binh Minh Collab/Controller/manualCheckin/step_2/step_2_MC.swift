//
//  step_2_MC.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/8/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
class step_2_MC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var student_id: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    private let refreshControl = UIRefreshControl()
    let APIManager = BinhMinhAPIManager()
    
    let hud = JGProgressHUD(style: .dark)
    var data = manualCheckinResponse.init(student_id: nil, student_name: nil, classrooms: nil)
    var selecting_row: Int = -1
    var class_name_selecting: String = ""
    let cellReuseIdentifier = "classroomCell"
    var params = manualCheckinResponseParams.init(student_id: nil, classroom_id: nil, event_id: nil)
    
    func fetchingData() {
        hud.textLabel.text = "Đang tải dữ liệu"
        hud.show(in: self.view)
        APIManager.manualCheckinGetData(id: params.student_id ?? 0, completion: {(_data, error) in
            self.data = _data!
            self.tableView.reloadData()
            self.hud.dismiss(afterDelay: 0.3)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchingData()
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }
    
    @objc private func updateData() {
        self.fetchingData()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if self.selecting_row == -1 {
            let alert = UIAlertController(title: "Vui lòng chọn lớp học", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "step_2", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "step_2" {
            let lectureSelectVC = segue.destination as? step_3_MC
            if let lsVC = lectureSelectVC {
                lsVC.class_name_selecting = self.class_name_selecting
                lsVC.data = (self.data.classrooms?[selecting_row] ?? nil)!
                lsVC.selecting_row = self.selecting_row
                lsVC.params = self.params
            }
        }
    }
}

