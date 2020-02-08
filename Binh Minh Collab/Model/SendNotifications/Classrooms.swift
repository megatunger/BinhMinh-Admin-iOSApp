//
//  Classrooms.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 08, 2020
//
import Foundation

struct Classrooms: Codable {

	let classFullName: String
	let classSchedule: String
	let classStudents: [EventStudents]

	private enum CodingKeys: String, CodingKey {
		case classFullName = "class_full_name"
		case classSchedule = "class_schedule"
		case classStudents = "class_students"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		classFullName = try values.decode(String.self, forKey: .classFullName)
		classSchedule = try values.decode(String.self, forKey: .classSchedule)
		classStudents = try values.decode([EventStudents].self, forKey: .classStudents)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(classFullName, forKey: .classFullName)
		try container.encode(classSchedule, forKey: .classSchedule)
		try container.encode(classStudents, forKey: .classStudents)
	}

}
