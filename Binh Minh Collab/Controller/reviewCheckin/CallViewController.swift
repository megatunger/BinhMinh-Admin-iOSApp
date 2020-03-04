//
//  CallViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 3/2/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class CallViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.tableData.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @objc private func updateData() {
        self.tableData.reloadData()
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
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showAlert(model: dataSource[indexPath.section].eventStudents[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableData.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        let event = dataSource[indexPath.section].eventStudents[indexPath.row]
        cell.titleLabel.text = "ID: \(event.id) - \(event.studentName)"
        cell.subtitleLabel.text = event.school
        return cell
    }
    
    func showAlert(model: EventStudents) {
        let alertController = UIAlertController(title: "Gọi Điện Cho", message: model.studentName, preferredStyle: .alert)
        
        let oneAction = UIAlertAction(title: "Mẹ", style: .default) { (_) in
            self.makePhoneCall(tel: model.motherPhone)
        }
        let twoAction = UIAlertAction(title: "Bố", style: .default) { (_) in
            self.makePhoneCall(tel: model.fatherPhone)
        }
        
        let threeAction = UIAlertAction(title: "Học sinh", style: .default) { (_) in
            self.makePhoneCall(tel: model.phone)
        }
        let cancelAction = UIAlertAction(title: "Đóng", style: .cancel) { (_) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(oneAction)
        alertController.addAction(twoAction)
        alertController.addAction(threeAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func makePhoneCall(tel: String) {
        if let url = URL(string: "tel://\(tel)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
