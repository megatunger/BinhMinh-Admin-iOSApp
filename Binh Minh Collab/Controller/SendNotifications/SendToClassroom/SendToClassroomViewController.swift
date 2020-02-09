//
//  SendToClassroomViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/8/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class SendToClassroomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var classroomsTable: UITableView!
    
    private let refreshControl = UIRefreshControl()
    var dataSource = [Classrooms]()
    var selectClassID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            self.classroomsTable.refreshControl = refreshControl
        } else {
            self.classroomsTable.addSubview(refreshControl)
        }
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.classroomsTable.reloadData()
        self.classroomsTable.allowsSelection = true
        updateData()
    }
    
    @objc private func updateData() {
        Constant.hud.show(in: self.view)
        Constant.APIManager.getClassrooms(completion: {(data, error) in
            Constant.hud.dismiss()
            self.dataSource = data ?? [Classrooms]()
            self.classroomsTable.reloadData()
        })
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Danh sách lớp học"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectClassID = dataSource[indexPath.row].classID
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = classroomsTable.dequeueReusableCell(withIdentifier: "ClassroomSendNotifyCell", for: indexPath) as! ClassroomSendNotifyCell
        let classroom = dataSource[indexPath.row]
        cell.titleLabel.text = classroom.classFullName
        cell.subtitleLabel.text = classroom.classSchedule
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedClassSendNotify" {
            if let destinationVC = segue.destination as? ListEventStudent {
                destinationVC.event_id = selectClassID
                destinationVC.type_case = "classroom"
            }
        }
    }
}
