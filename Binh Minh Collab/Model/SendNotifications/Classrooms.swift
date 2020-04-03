//
//  Classrooms.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 08, 2020
//
import Foundation

struct Classrooms: Codable {
    let classID: Int
	let classFullName: String
	let classSchedule: String
	let classStudents: [EventStudents]

	private enum CodingKeys: String, CodingKey {
        case classID = "class_id"
		case classFullName = "class_full_name"
		case classSchedule = "class_schedule"
		case classStudents = "class_students"
	}

    
    init() {
        classID = 0
        classFullName = Constant.unknown
        classSchedule = Constant.unknown
        classStudents = []
    }
    
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        classID = try values.decode(Int.self, forKey: .classID)
		classFullName = try values.decode(String.self, forKey: .classFullName)
		classSchedule = try values.decode(String.self, forKey: .classSchedule)
		classStudents = try values.decode([EventStudents].self, forKey: .classStudents)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(classID, forKey: .classID)
		try container.encode(classFullName, forKey: .classFullName)
		try container.encode(classSchedule, forKey: .classSchedule)
		try container.encode(classStudents, forKey: .classStudents)
	}

}
