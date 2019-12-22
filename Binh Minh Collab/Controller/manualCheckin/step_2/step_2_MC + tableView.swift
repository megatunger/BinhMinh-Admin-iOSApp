//
//  step_2_MC + tableView.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/9/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit

extension step_2_MC {
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.classrooms?.count ?? 1
    }

    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassroomCell", for: indexPath) as! ClassroomCell
        cell.classroom_title.text = self.data.classrooms?[indexPath.row].class_name ?? "Đang tải dữ liệu..."
        cell.classroom_description.text = self.data.classrooms?[indexPath.row].class_description ?? "Đang tải dữ liệu..."
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        self.selecting_row = indexPath.row
        self.class_name_selecting = self.data.classrooms?[indexPath.row].class_name ?? "Đang tải dữ liệu..."
        self.params.classroom_id = self.data.classrooms?[indexPath.row].class_id ?? nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Danh sách lớp học của '\(self.data.student_name ?? "Không rõ")'"
    }
    
    
}
