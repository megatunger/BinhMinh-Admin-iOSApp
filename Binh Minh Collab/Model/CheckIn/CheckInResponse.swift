//
//  CheckInResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 03, 2020
//
import Foundation

struct CheckInResponse: Codable {

	let status: String
	let errorExplain: String
	let checkInDetails: CheckInDetails?

	private enum CodingKeys: String, CodingKey {
		case status = "status"
		case errorExplain = "error_explain"
		case checkInDetails = "check_in_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decode(String.self, forKey: .status)
		errorExplain = try values.decode(String.self, forKey: .errorExplain)
        if values.contains(.checkInDetails) {
            checkInDetails = try values.decode(CheckInDetails.self, forKey: .checkInDetails)
        } else {
            checkInDetails = nil
        }
        
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(status, forKey: .status)
		try container.encode(errorExplain, forKey: .errorExplain)
		try container.encode(checkInDetails, forKey: .checkInDetails)
	}

}
