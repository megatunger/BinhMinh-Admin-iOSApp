//
//  AutoCheckInRequest.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 31, 2020
//
import Foundation

struct AutoCheckInRequest: Codable {

	let loginToken: String
	let otp: String

	private enum CodingKeys: String, CodingKey {
		case loginToken = "login_token"
		case otp = "otp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		loginToken = try values.decode(String.self, forKey: .loginToken)
		otp = try values.decode(String.self, forKey: .otp)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(loginToken, forKey: .loginToken)
		try container.encode(otp, forKey: .otp)
	}

}