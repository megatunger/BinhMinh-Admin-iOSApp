//
//  Avatar.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 04, 2020
//
import Foundation

struct Avatar: Codable {

	let url: String
	let thumb: Thumb

	private enum CodingKeys: String, CodingKey {
		case url = "url"
		case thumb = "thumb"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decode(String.self, forKey: .url)
		thumb = try values.decode(Thumb.self, forKey: .thumb)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(url, forKey: .url)
		try container.encode(thumb, forKey: .thumb)
	}

}