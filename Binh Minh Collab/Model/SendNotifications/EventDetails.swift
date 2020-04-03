//
//  EventDetails.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 06, 2020
//
import Foundation

struct EventDetails: Codable {

    let eventId: Int
    let classroom: String
    let timeInText: String
    let eventStudents: [EventStudents]

    private enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case classroom = "classroom"
        case timeInText = "time_in_text"
        case eventStudents = "event_students"
    }

    init() {
        eventId = 0
        classroom = "Đang cập nhật..."
        timeInText = "Đang cập nhật..."
        eventStudents = []
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eventId = try values.decode(Int.self, forKey: .eventId)
        classroom = try values.decode(String.self, forKey: .classroom)
        timeInText = try values.decode(String.self, forKey: .timeInText)
        eventStudents = try values.decode([EventStudents].self, forKey: .eventStudents)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(classroom, forKey: .classroom)
        try container.encode(timeInText, forKey: .timeInText)
        try container.encode(eventStudents, forKey: .eventStudents)
    }

}
