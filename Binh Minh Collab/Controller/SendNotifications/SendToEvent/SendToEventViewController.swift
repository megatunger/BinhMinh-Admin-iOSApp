//
//  SendToEventViewController.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/6/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

class SendToEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var EventTable: UITableView!
    private let refreshControl = UIRefreshControl()
    var dataSource = [WeekDay]()
    var selectEventID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            self.EventTable.refreshControl = refreshControl
        } else {
            self.EventTable.addSubview(refreshControl)
        }
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.EventTable.reloadData()
        self.EventTable.allowsSelection = true
        updateData()
    }
    
    @objc private func updateData() {
        Constant.hud.show(in: self.view)
        Constant.APIManager.getEvents(completion: {(data, error) in
            Constant.hud.dismiss()
            self.dataSource = data ?? [WeekDay]()
            self.EventTable.reloadData()
        })
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].events.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].wdayName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectEventID = dataSource[indexPath.section].events[indexPath.row].id
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventTable.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        let event = dataSource[indexPath.section].events[indexPath.row]
        cell.titleLabel.text = event.classroom
        cell.subtitleLabel.text = event.timeInText
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectEventStudents" {
            if let destinationVC = segue.destination as? ListEventStudent {
                destinationVC.event_id = selectEventID
            }
        }
    }

}
