//
//  NetworkManager.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/16/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

let token = Constant.apiToken ?? ""
let authPlugin = AccessTokenPlugin { token }

class BinhMinhAPIManager: Networkable {
    
    var provider = MoyaProvider<BinhMinhAPI>(plugins: [NetworkLoggerPlugin(verbose: true), authPlugin])
    
    
    func login(email: String, password: String, completion: @escaping (Response?, Error?) -> ()) {
        provider.request(.login(email: email, password: password))
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode(Response.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func testConnection(completion: @escaping (Response?, Error?) -> ()) {
        provider.request(.testConnection)
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode(Response.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getStudentDetail(encrypted_id: String, completion: @escaping (StudentDetails?, Error?) -> ()) {
        provider.request(.getStudentDetail(encrypted_id: encrypted_id))
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let student = try decoder.decode(StudentDetails.self, from: value.data)
                    completion(student, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func autoCheckIn(login_token: String, otp: String, completion: @escaping (CheckInResponse?, Error?) -> ()) {
        provider.request(.autoCheckIn(login_token: login_token, otp: otp))
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                print(value.data)
                do {
                    let x = try decoder.decode(CheckInResponse.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getAbsentList(completion: @escaping ([EventDetails]?, Error?) -> ()) {
        provider.request(.getAbsentList)
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                print(value.data)
                do {
                    let x = try decoder.decode([EventDetails]?.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func manualCheckinGetData(id: Int, completion: @escaping (manualCheckinResponse?, Error?) -> ()) {
        provider.request(.manualCheckinGetData(id: id))
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                do {
                    let json = try JSON(data: value.data)
                    var model_classrooms = Array<manualCheckinResponse_Classroom>()
                    for (_, _subJson_1):(String, JSON) in json["classrooms"] {
                        
                        var model_lectures = Array<manualCheckinResponse_Classroom_Lecture>()
                        for (_, _subJson_2):(String, JSON) in _subJson_1["lectures"] {
                            let x = manualCheckinResponse_Classroom_Lecture.init(
                                lecture_id: _subJson_2["lecture_id"].intValue,
                                lecture_name: _subJson_2["lecture_name"].stringValue,
                                lecture_description: _subJson_2["lecture_description"].stringValue
                            )
                            model_lectures.append(x)
                        }
                        
                        let model_classroom = manualCheckinResponse_Classroom.init(
                            class_id: _subJson_1["class_id"].intValue,
                            class_name: _subJson_1["class_name"].stringValue,
                            class_description: _subJson_1["class_description"].stringValue,
                            lectures: model_lectures)
                        
                        model_classrooms.append(model_classroom)
                    }
                    
                    let model = manualCheckinResponse.init(student_id: json["student_id"].intValue,
                                                           student_name: json["student_name"].stringValue,
                                                           classrooms: model_classrooms)
                    completion(model, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func manualCheckinSubmitData(student_id: Int, classroom_id: Int, event_id: Int, completion: @escaping (Response?, Error?) -> ()) {
        provider.request(.manualCheckinSubmitData(student_id: student_id, classroom_id: classroom_id, event_id: event_id))
        { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode(Response.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getEvents(completion: @escaping ([WeekDay]?, Error?) -> ()) {
        provider.request(.getEvents) {
            (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode([WeekDay].self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getEventStudents(event_id: Int, completion: @escaping (EventDetails?, Error?) -> ()) {
        provider.request(.getEventStudents(event_id: event_id)) {
            (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode(EventDetails.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func sendNotifications(title: String, description: String, student_ids: [Int], completion: @escaping (Response?, Error?) -> ()) {
        provider.request(.sendNotifications(title: title, description: description, student_ids: student_ids)) {
            (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode(Response.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func sendNotificationsToAll(title: String, description: String, completion: @escaping (Response?, Error?) -> ()) {
        provider.request(.sendNotificationsToAll(title: title, description: description)) {
            (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode(Response.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func searchStudent(query: String, completion: @escaping ([EventStudents]?, Error?) -> ()) {
        provider.request(.searchStudent(query: query)) {
            (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode([EventStudents].self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    print(error)
                    completion(nil, error)
                }
            }
        }
    }
    
    func getClassrooms(completion: @escaping ([Classrooms]?, Error?) -> ()) {
        provider.request(.getClassrooms) {
            (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode([Classrooms].self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    print(error)
                    completion(nil, error)
                }
            }
        }
    }
    
    func getClassrooomStudents(class_id: Int, completion: @escaping (EventDetails?, Error?) -> ()) {
        provider.request(.getClassroomStudents(class_id: class_id)) {
            (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let x = try decoder.decode(EventDetails.self, from: value.data)
                    completion(x, nil)
                } catch let error {
                    print(error)
                    completion(nil, error)
                }
            }
        }
    }
    
}

extension BinhMinhAPIManager {
    func cleanPhoneNumber(number: String) -> String {
        return number.filter("0123456789".contains)
    }
}

