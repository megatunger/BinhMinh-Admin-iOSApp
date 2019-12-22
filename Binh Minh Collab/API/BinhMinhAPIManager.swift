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
                    let student = try decoder.decode(Student.self, from: value.data)
                    completion(student, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func autoCheckIn(id: Int, completion: @escaping (CheckInResponse?, Error?) -> ()) {
        provider.request(.autoCheckIn(id: id))
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
    
    func getAbsentList(completion: @escaping ([Section]?, Error?) -> ()) {
        provider.request(.getAbsentList) {
            (response) in
            switch response.result {
                        case .failure(let error):
                            completion(nil, error)
                        case .success(let value):
                             var sections = [Section]()
                             do {
                                let json = try JSON(data: value.data)
                                for (_,subJson):(String, JSON) in json["results"] {
                                    var Students_Off_Per_Class = [Student_Off]()
                                    for (_index, _subJson):(String, JSON) in subJson["students"] {
                                        print(_index)
                                        print(_subJson)
                                        let x = Student_Off.init(id: _subJson["id"].intValue,
                                                                 name: "ID: \(_subJson["id"].intValue) - \(_subJson["student_name"].stringValue)",
                                                                 phone: self.cleanPhoneNumber(number: _subJson["phone"].stringValue),
                                                                 description: _subJson["school"].stringValue,
                                                                 class_id: 1,
                                                                 father: Father.init(name: _subJson["father_name"].stringValue, phone: self.cleanPhoneNumber(number: _subJson["father_phone"].stringValue)),
                                                                 mother: Mother.init(name: _subJson["mother_name"].stringValue, phone: self.cleanPhoneNumber(number: _subJson["mother_phone"].stringValue)),
                                                                 avatar: Constant.baseURL + _subJson["avatar"]["thumb"]["url"].stringValue
                                        )
                                        Students_Off_Per_Class.append(x)
                                    }
                                    let section = Section.init(class_id: subJson["class_id"].intValue,
                                                               class_name: subJson["class_name"].stringValue + ". " + subJson["time"].stringValue,
                                                 students: Students_Off_Per_Class
                                    )
                                    sections.append(section)
                                }
                                completion(sections, nil)
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
    
    func manualCheckinSubmitData(student_id: Int, classroom_id: Int, event_id: Int, completion: @escaping (manualCheckinSubmitResponse?, Error?) -> ()) {
           provider.request(.manualCheckinSubmitData(student_id: student_id, classroom_id: classroom_id, event_id: event_id))
           { (response) in
               switch response.result {
               case .failure(let error):
                   completion(nil, error)
               case .success(let value):
                   do {
                       let json = try JSON(data: value.data)
                        let x = manualCheckinSubmitResponse.init(status: json["status"].stringValue, explain: json["explained"].stringValue)
                       completion(x, nil)
                   } catch let error {
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
