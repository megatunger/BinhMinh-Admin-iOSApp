//
//  ReviewCheckinViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 3/2/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class ReviewCheckinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableData: UITableView!
    private let refreshControl = UIRefreshControl()
    var dataSource = [EventDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            self.tableData.refreshControl = refreshControl
        } else {
            self.tableData.addSubview(refreshControl)
        }
        ButtonStyle()
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        updateData()
        self.tableData.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func updateData() {
        Constant.hud.show(in: self.view)
        Constant.APIManager.getAbsentList(completion: {(data, error) in
            Constant.hud.dismiss(animated: true)
            self.dataSource = data ?? [EventDetails]()
            self.tableData.reloadData()
        })
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].eventStudents.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(dataSource[section].classroom) - \(dataSource[section].timeInText)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableData.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        let event = dataSource[indexPath.section].eventStudents[indexPath.row]
        cell.titleLabel.text = "ID: \(event.id) - \(event.studentName)"
        cell.subtitleLabel.text = event.school
        return cell
    }
    
    private func ButtonStyle() {
        closeButton.layer.cornerRadius = CGFloat(Constant.cornerRadius)
        closeButton.layer.borderWidth = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextToCall" {
            if let destinationVC = segue.destination as? CallViewController {
                destinationVC.dataSource = self.dataSource
            }
        }
        
        if segue.identifier == "selectedEventStudents" {
            let selectedRows = tableData.indexPathsForSelectedRows
            if (selectedRows == nil) {
                // CASE: No Student Selected
                let alert = UIAlertController(title: "Chưa chọn học sinh", message: "Vui lòng tích vào các học sinh cần gửi", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                var selectedData = [EventStudents]()
                for (indexPath) in selectedRows ?? [IndexPath.init()] {
                    selectedData.append(dataSource[indexPath.section].eventStudents[indexPath.row])
                }
                if let destinationVC = segue.destination as? ContentSendEvent {
                    destinationVC.selectedStudentID = selectedData
                }
            }
        }
    }
    
    @IBAction func closeButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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
