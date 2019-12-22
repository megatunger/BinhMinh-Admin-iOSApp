//
//  ContactCell.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/25/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var student_name: UILabel!
    @IBOutlet weak var student_description: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = 24
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
