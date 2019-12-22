//
//  Student_Off.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/25/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import UIKit
struct Father {
    var name: String
    var phone: String
}

struct Mother {
    var name: String
    var phone: String
}

struct Student_Off {
    var id: Int
    var name: String
    var phone: String
    var description: String
    var class_id: Int
    var father: Father!
    var mother: Mother!
    var avatar: String
}
