//
//  WeekDay.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on February 06, 2020
//
import Foundation

struct WeekDay: Codable {

    let wdayName: String
    let events: [Events]

    private enum CodingKeys: String, CodingKey {
        case wdayName = "wday_name"
        case events = "events"
    }

    init() {
        wdayName = "Đang cập nhật..."
        events = []
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        wdayName = try values.decode(String.self, forKey: .wdayName)
        events = try values.decode([Events].self, forKey: .events)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wdayName, forKey: .wdayName)
        try container.encode(events, forKey: .events)
    }

}
