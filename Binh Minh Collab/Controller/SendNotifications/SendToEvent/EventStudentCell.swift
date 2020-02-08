//
//  EventStudentCell.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 2/6/20.
//  Copyright © 2020 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

class EventStudentCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.accessoryType = .checkmark
            contentView.backgroundColor = UIColor(red:0.81, green:0.81, blue:0.81, alpha:1.0)
        } else {
            self.accessoryType = .none
            contentView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        }
    }
}
