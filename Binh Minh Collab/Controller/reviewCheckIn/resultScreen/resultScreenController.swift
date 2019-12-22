//
//  resultScreen.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/23/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
class resultScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    let APIManager = BinhMinhAPIManager()
    var sections = [Section]()
    let hud = JGProgressHUD(style: .dark)
    private let refreshControl = UIRefreshControl()
    
    @IBAction func completeTap(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    func groupDataToSection() {
        hud.textLabel.text = "Đang tải dữ liệu"
        hud.show(in: self.view)
        APIManager.getAbsentList(completion: {(data, error) in
            self.sections = data ?? [Section]()
            self.tableData.reloadData()
            self.hud.dismiss(afterDelay: 0.3)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        groupDataToSection()
        self.tableData.reloadData()
        
        if #available(iOS 10.0, *) {
            self.tableData.refreshControl = refreshControl
        } else {
            self.tableData.addSubview(refreshControl)
        }
        
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc private func updateData() {
        self.groupDataToSection()
        self.refreshControl.endRefreshing()
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {

        if sender.state == UIGestureRecognizer.State.began {

            let touchPoint = sender.location(in: self.tableData)
            if let indexPath = tableData.indexPathForRow(at: touchPoint) {
                let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                    
                // 2
                let deleteAction = UIAlertAction(title: "Đã xin nghỉ", style: .destructive, handler: {
                    (action) -> Void in
                        self.sections[indexPath[0]].students.remove(at: indexPath[1])
                        self.tableData.reloadData()
                        print("Long pressed row: \(indexPath)")
                    })

                // 3
                let cancelAction = UIAlertAction(title: "Đóng", style: .cancel)
                    
                // 4
                optionMenu.addAction(deleteAction)
                optionMenu.addAction(cancelAction)
                    
                // 5
                self.present(optionMenu, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendSiblings" {
            let sendSiblingsVC = segue.destination as? sendSiblings
            if let svc = sendSiblingsVC {
                svc.sections = self.sections
            }
        }
        if segue.identifier == "callSiblings" {
            let callSiblingsVC = segue.destination as? callSiblings
            if let cvc = callSiblingsVC {
                cvc.sections = self.sections
            }
        }
    }
    
}
