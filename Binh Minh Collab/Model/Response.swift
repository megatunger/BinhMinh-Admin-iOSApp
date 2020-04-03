//
//  LoginResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 04, 2020
//
import Foundation

struct Response: Codable {

	let status: String
	let errorExplain: String

	private enum CodingKeys: String, CodingKey {
		case status = "status"
		case errorExplain = "error_explain"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decode(String.self, forKey: .status)
		errorExplain = try values.decode(String.self, forKey: .errorExplain)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(status, forKey: .status)
		try container.encode(errorExplain, forKey: .errorExplain)
	}

}
