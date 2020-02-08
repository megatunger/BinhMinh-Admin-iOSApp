//
//  EventStudents.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 06, 2020
//
import Foundation

struct EventStudents: Codable {

	let id: Int
	let studentName: String
    let phone: String
	let school: String
	let fatherPhone: String
	let motherPhone: String
    let birthday: String
    
	private enum CodingKeys: String, CodingKey {
		case id = "id"
		case studentName = "student_name"
		case phone = "phone"
		case school = "school"
        case birthday = "birthday"
		case fatherPhone = "father_phone"
		case motherPhone = "mother_phone"
	}

    init() {
        id = 0
        studentName = ""
        phone = ""
        school = ""
        fatherPhone = ""
        motherPhone = ""
        birthday = ""
    }
    
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
        self.studentName = try values.decodeIfPresent(String.self, forKey: .studentName) ?? Constant.unknown
        self.phone = try values.decodeIfPresent(String.self, forKey: .phone) ?? Constant.unknown
        self.school = try values.decodeIfPresent(String.self, forKey: .school) ?? Constant.unknown
        self.fatherPhone = try values.decodeIfPresent(String.self, forKey: .fatherPhone) ?? Constant.unknown
        self.motherPhone = try values.decodeIfPresent(String.self, forKey: .motherPhone) ?? Constant.unknown
        self.birthday = try values.decodeIfPresent(String.self, forKey: .birthday) ?? Constant.unknown
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(studentName, forKey: .studentName)
		try container.encode(phone, forKey: .phone)
		try container.encode(school, forKey: .school)
		try container.encode(fatherPhone, forKey: .fatherPhone)
		try container.encode(motherPhone, forKey: .motherPhone)
        try container.encode(birthday, forKey: .birthday)
	}

}
