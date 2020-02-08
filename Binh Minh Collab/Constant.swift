//
//  Constant.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/12/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import JGProgressHUD
struct Constant {
    
    static var cornerRadius = 15
    
//    static var baseURL = "https://binhminh.megatunger.codes"
    static var baseURL = "http://172.16.2.190:3000"
    
    static let APIManager = BinhMinhAPIManager()
    
    static var hud = JGProgressHUD(style: .dark)
    
    static let apiToken = UserDefaults.standard.string(forKey: "apiToken")
    
    static let unknown = "Đang cập nhật"
}
