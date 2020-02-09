//
//  ListEventStudents.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/6/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

class ListEventStudent: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var event_id = 0
    var type_case = ""
    
    @IBOutlet weak var studentListTable: UITableView!
    private let refreshControl = UIRefreshControl()
    var dataSource = EventDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            self.studentListTable.refreshControl = refreshControl
        } else {
            self.studentListTable.addSubview(refreshControl)
        }
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.studentListTable.reloadData()
        self.studentListTable.allowsSelection = true
        updateData()
    }
    
    @objc private func updateData() {
        Constant.hud.show(in: self.view)
        switch type_case {
        case "event":
            Constant.APIManager.getEventStudents(event_id: event_id, completion: {(data, error) in
                Constant.hud.dismiss()
                self.dataSource = data ?? EventDetails()
                self.studentListTable.reloadData()
                self.refreshControl.endRefreshing()
                self.selectAllStudents()
                
            })
            break
        case "classroom":
            Constant.APIManager.getClassrooomStudents(class_id: event_id, completion: {(data, error) in
                Constant.hud.dismiss()
                self.dataSource = data ?? EventDetails()
                self.studentListTable.reloadData()
                self.refreshControl.endRefreshing()
                self.selectAllStudents()
            })
            break
        default:
            break
        }
    }

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.eventStudents.count
}
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dataSource.classroom + " :: " + dataSource.timeInText
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = studentListTable.dequeueReusableCell(withIdentifier: "EventStudentCell", for: indexPath) as! EventStudentCell
    let student = dataSource.eventStudents[indexPath.row]
    cell.titleLabel.text = student.studentName
    cell.subtitleLabel.text = "ID: \(student.id)"
    return cell
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "selectedEventStudents" {
        let selectedRows = studentListTable.indexPathsForSelectedRows
        let selectedData = selectedRows?.map { dataSource.eventStudents[$0.row] }
        if (selectedData == nil) {
            // CASE: No Student Selected
            let alert = UIAlertController(title: "Chưa chọn học sinh", message: "Vui lòng tích vào các học sinh cần gửi", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if let destinationVC = segue.destination as? ContentSendEvent {
                destinationVC.selectedStudentID = selectedData ?? [EventStudents]()
            }
        }
    }
}
}

extension ListEventStudent {
    func selectAllStudents() {
        // Always select all students first time
        let sectionCount = self.studentListTable.numberOfSections
        for section in 0..<sectionCount {
            if self.studentListTable.numberOfRows(inSection: section) > 0 {
                for row in 0..<self.studentListTable.numberOfRows(inSection: section) {
                    let indexPath = IndexPath(row: row, section: section)
                    self.studentListTable.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                }
            }
        }
    }
}
