//
//  sendSiblings.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/25/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class sendSiblings: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var tableData: UITableView!
    @IBOutlet weak var sendMessageButton: UIButton!
    var sections = [Section]()
    var Student_Selected = [IndexPath]()
    var count = 0
    
    
    @IBAction func sendMessageButton(_: AnyObject) {
        self.generateComposeMessage()
        count+=1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        Style()
        self.tableData.reloadData()
    }
}

