//
//  manualCheckinResponse.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 10/9/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
struct manualCheckinResponse {
    let student_id: Int?
    let student_name: String?
    let classrooms: [manualCheckinResponse_Classroom]?
    
}

struct manualCheckinResponse_Classroom {
    let class_id: Int?
    let class_name: String?
    let class_description: String?
    let lectures: [manualCheckinResponse_Classroom_Lecture]?
}

struct manualCheckinResponse_Classroom_Lecture {
    let lecture_id: Int?
    let lecture_name: String?
    let lecture_description: String?
}

struct manualCheckinResponseParams {
    var student_id: Int?
    var classroom_id: Int?
    var event_id: Int?
}

struct manualCheckinSubmitResponse {
    var status: String
    var explain: String
}
