//
//  Student.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/15/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
typealias Codable = Encodable & Decodable

struct Student: Codable {
    var id: Int
    var name: String
    var birthday: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, birthday, image
    }
}
