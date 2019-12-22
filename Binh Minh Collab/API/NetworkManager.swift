//
//  NetworkManager.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/16/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import Moya

class BinhMinhAPIManager: Networkable {
    var provider = MoyaProvider<BinhMinhAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getStudentDetail(id: Int, completion: @escaping (Student?, Error?) -> ()) {
        provider.request(.getStudentDetail(id: id))
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let post = try decoder.decode(Student.self, from: value.data)
                    completion(post, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
}

