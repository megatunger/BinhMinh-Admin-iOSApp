//
//  CheckInDetails.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 03, 2020
//
import Foundation

struct CheckInDetails: Codable {

	let classroomId: Int
	let classroomName: String
	let numberStudents: Int
	let currentStudents: Int

	private enum CodingKeys: String, CodingKey {
		case classroomId = "classroom_id"
		case classroomName = "classroom_name"
		case numberStudents = "number_students"
		case currentStudents = "current_students"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		classroomId = try values.decode(Int.self, forKey: .classroomId)
		classroomName = try values.decode(String.self, forKey: .classroomName)
		numberStudents = try values.decode(Int.self, forKey: .numberStudents)
		currentStudents = try values.decode(Int.self, forKey: .currentStudents)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(classroomId, forKey: .classroomId)
		try container.encode(classroomName, forKey: .classroomName)
		try container.encode(numberStudents, forKey: .numberStudents)
		try container.encode(currentStudents, forKey: .currentStudents)
	}

}