//
//  sendSiblings+tableView.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/27/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
import LTHRadioButton
extension sendSiblings {
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
        
        print(indexPath)
        let model = self.sections[indexPath[0]].students[indexPath[1]]
        cell.student_name.text = model.name
        cell.student_description.text = model.description
        cell.isUserInteractionEnabled = true
        cell.avatar.kf.setImage(with: URL(string: model.avatar))
        //TODO: ADD RADIO BUTTON
        
//        let radioButton = LTHRadioButton.init(diameter: 24, selectedColor: nil, deselectedColor: nil)
//        cell.addSubview(radioButton)
//        radioButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//          radioButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
//          radioButton.leadingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -58),
//          radioButton.heightAnchor.constraint(equalToConstant: radioButton.frame.height),
//          radioButton.widthAnchor.constraint(equalToConstant: radioButton.frame.width)]
//        )
//        radioButton.select()
//
//        //AUTO SELECT ALL STUDENT BY DEFAULTS
//        self.Student_Selected.append(indexPath)
//
//        //CALLBACKS
//        radioButton.onSelect {
//            self.Student_Selected.append(indexPath)
//            self.Student_Selected.sort()
//            print("I'm selected. \(indexPath)")
//            print(self.Student_Selected)
//        }
//
//        radioButton.onDeselect {
//            self.Student_Selected = self.Student_Selected.filter {$0 != indexPath}
//            self.Student_Selected.sort()
//            print("I'm deselected. \(indexPath)")
//            print(self.Student_Selected)
//        }
        
        return cell
    }
    
}
