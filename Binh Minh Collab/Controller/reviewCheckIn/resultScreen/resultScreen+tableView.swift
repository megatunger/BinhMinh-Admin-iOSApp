//
//  resultScreen+tableView.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/27/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension resultScreenController {
    func numberOfSections(in tableView: UITableView) -> Int {
          return sections.count
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.sections[section].students.count
      }
      func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          return self.sections[section].class_name
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableData.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
          let model = self.sections[indexPath[0]].students[indexPath[1]]
          cell.student_name.text = model.name
          cell.student_description.text = model.description
          cell.avatar.kf.setImage(with: URL(string: model.avatar))
          cell.isUserInteractionEnabled = false
          return cell
      }
}
