//
//  StudentDetails.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 04, 2020
//
import Foundation

struct StudentDetails: Codable {

    let id: Int
    let studentName: String
    let avatar: Avatar
    let sex: Bool
    let phone: String
    let school: String
    let birthday: String
    let address: String
    let fatherName: String
    let fatherPhone: String
    let motherName: String
    let motherPhone: String
    let email: String
    let status: Int
    let khoiThi: String
    let diemVao10: String
    let ngayDk: String
    let note: String
    let studentCardImage: StudentCardImage
    let qrCodeImage: QrCodeImage
    let parking: Bool
    let infrastructurePaid: String
    let updatedAt: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case studentName = "student_name"
        case avatar = "avatar"
        case sex = "sex"
        case phone = "phone"
        case school = "school"
        case birthday = "birthday"
        case address = "address"
        case fatherName = "father_name"
        case fatherPhone = "father_phone"
        case motherName = "mother_name"
        case motherPhone = "mother_phone"
        case email = "email"
        case status = "status"
        case khoiThi = "khoi_thi"
        case diemVao10 = "diem_vao_10"
        case ngayDk = "ngay_dk"
        case note = "note"
        case studentCardImage = "student_card_image"
        case qrCodeImage = "qr_code_image"
        case parking = "parking"
        case infrastructurePaid = "infrastructure_paid"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        studentName = try values.decode(String.self, forKey: .studentName)
        avatar = try values.decode(Avatar.self, forKey: .avatar)
        sex = try values.decode(Bool.self, forKey: .sex)
        phone = try values.decode(String.self, forKey: .phone)
        school = try values.decode(String.self, forKey: .school)
        birthday = try values.decode(String.self, forKey: .birthday)
        address = try values.decode(String.self, forKey: .address)
        fatherName = try values.decode(String.self, forKey: .fatherName)
        fatherPhone = try values.decode(String.self, forKey: .fatherPhone)
        motherName = try values.decode(String.self, forKey: .motherName)
        motherPhone = try values.decode(String.self, forKey: .motherPhone)
        email = try values.decode(String.self, forKey: .email)
        status = try values.decode(Int.self, forKey: .status)
        khoiThi = try values.decode(String.self, forKey: .khoiThi)
        diemVao10 = try values.decode(String.self, forKey: .diemVao10)
        ngayDk = try values.decode(String.self, forKey: .ngayDk)
        note = try values.decode(String.self, forKey: .note)
        studentCardImage = try values.decode(StudentCardImage.self, forKey: .studentCardImage)
        qrCodeImage = try values.decode(QrCodeImage.self, forKey: .qrCodeImage)
        parking = try values.decode(Bool.self, forKey: .parking)
        infrastructurePaid = try values.decode(String.self, forKey: .infrastructurePaid)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(studentName, forKey: .studentName)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(sex, forKey: .sex)
        try container.encode(phone, forKey: .phone)
        try container.encode(school, forKey: .school)
        try container.encode(birthday, forKey: .birthday)
        try container.encode(address, forKey: .address)
        try container.encode(fatherName, forKey: .fatherName)
        try container.encode(fatherPhone, forKey: .fatherPhone)
        try container.encode(motherName, forKey: .motherName)
        try container.encode(motherPhone, forKey: .motherPhone)
        try container.encode(email, forKey: .email)
        try container.encode(status, forKey: .status)
        try container.encode(khoiThi, forKey: .khoiThi)
        try container.encode(diemVao10, forKey: .diemVao10)
        try container.encode(ngayDk, forKey: .ngayDk)
        try container.encode(note, forKey: .note)
        try container.encode(studentCardImage, forKey: .studentCardImage)
        try container.encode(qrCodeImage, forKey: .qrCodeImage)
        try container.encode(parking, forKey: .parking)
        try container.encode(infrastructurePaid, forKey: .infrastructurePaid)
        try container.encode(updatedAt, forKey: .updatedAt)
    }

}
