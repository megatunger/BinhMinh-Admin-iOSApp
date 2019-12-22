//
//  step_3_MC + tableView.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/10/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

extension step_3_MC {
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.lectures?.count ?? 1
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "LectureCell", for: indexPath) as! LectureCell
        
        
//        print(data.classrooms?[selecting_row].lectures?[indexPath.row].lecture_name ?? "Đang cập nhật")
        cell.lecture_name.text = self.data.lectures?[indexPath.row].lecture_name ?? "Đang cập nhật"
        
        cell.lecture_description.text = self.data.lectures?[indexPath.row].lecture_description ?? "Đang cập nhật..."
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        self.params.event_id = self.data.lectures?[indexPath.row].lecture_id
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Các ca học của lớp \(self.class_name_selecting)"
    }
    
    
}
