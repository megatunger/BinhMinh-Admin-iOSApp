//
//  CheckInResponse.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/22/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation

struct CheckInResponse: Codable {
    var status: String
    var classroom_id: Int
    var classroom_name: String
    var classroom_students: Int
    var lecture_students: Int
    
    enum CodingKeys: String, CodingKey {
        case status, classroom_id, classroom_name, classroom_students, lecture_students
    }
    
}



//EXAMPLE OF JSON RESPONSE
let jsonData = """
{
    "status": "success",
    "classroom_id": 1,
    "classroom_students": 4,
    "lecture_students": 2
}
"""
