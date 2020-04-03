//
//  Thumb.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 04, 2020
//
import Foundation

struct Thumb: Codable {

	let url: String

	private enum CodingKeys: String, CodingKey {
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decode(String.self, forKey: .url)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(url, forKey: .url)
	}

}