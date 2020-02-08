//
//  Events.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 06, 2020
//
import Foundation

struct Events: Codable {

	let id: Int
	let classroom: String
	let timeInText: String

	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case classroom = "classroom"
		case timeInText = "time_in_text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
		classroom = try values.decode(String.self, forKey: .classroom)
		timeInText = try values.decode(String.self, forKey: .timeInText)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(classroom, forKey: .classroom)
		try container.encode(timeInText, forKey: .timeInText)
	}

}