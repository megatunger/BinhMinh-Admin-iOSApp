//
//  BinhMinhAPI.swift
//  Binh Minh Collab
//
//  Created by Hoàng Sơn Tùng on 9/16/19.
//  Copyright © 2019 Hoàng Sơn Tùng. All rights reserved.
//

import Foundation
import Moya


public enum BinhMinhAPI {
    case login(email: String, password: String)
    case testConnection
    case getStudentDetail(id: Int)
    case autoCheckIn(login_token: String, otp: String)
    case getAbsentList
    case manualCheckinGetData(id: Int)
    case manualCheckinSubmitData(student_id: Int, classroom_id: Int, event_id: Int)
    case getEvents
    case getEventStudents(event_id: Int)
    case sendNotifications(title: String, description: String, student_ids: [Int])
    case sendNotificationsToAll(title: String, description: String)
    case searchStudent(query: String)
    case getClassrooms
    case getClassroomStudents(class_id: Int)
    
}

extension BinhMinhAPI: TargetType, AccessTokenAuthorizable {
    
    public var baseURL: URL { return URL(string: Constant.baseURL+"/api/v2/admin")!}
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/login"
        case .testConnection:
            return "/test-connection"
        case .getStudentDetail(let id):
            return "/students/\(id).json"
        case .autoCheckIn( _, _):
            return "/check-in"
        case .getAbsentList:
            return "/absent-students"
        case .manualCheckinGetData:
            return "/manual-check-in"
        case .manualCheckinSubmitData:
            return "/manual-check-in"
        case .searchStudent:
            return "/search/student"
        case .getEvents:
            return "/notifications/get-events"
        case .getEventStudents:
            return "/notifications/get-students"
        case .sendNotifications:
            return "/notifications/send-notifications"
        case .sendNotificationsToAll:
            return "/notifications/send-notifications-to-all"
        case .getClassrooms:
            return "/notifications/get-classrooms"
        case .getClassroomStudents:
            return "/notifications/get-students"
        }
    }
    
    public var method: Moya.Method {
        switch self {
            case .login:
                return .post
            case .testConnection:
                return .get
            case .getStudentDetail:
                return .get
            case .autoCheckIn:
                return .post
            case .getAbsentList:
                return .get
            case .manualCheckinGetData:
                return .get
            case .manualCheckinSubmitData:
                return .post
            case .searchStudent:
                return .get
            case .getEvents:
                return .get
            case .getEventStudents:
                return .get
            case .sendNotifications:
                return .post
            case .sendNotificationsToAll:
                return .post
            case .getClassrooms:
                return .get
            case .getClassroomStudents:
                return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.queryString)
        case .testConnection:
            return .requestPlain
        case .getStudentDetail:
            return .requestPlain
            
        // Checkin features
        case .autoCheckIn(let login_token, let otp):
            return .requestParameters(parameters: ["login_token" : login_token, "otp" : otp], encoding: URLEncoding.queryString)
        case .getAbsentList:
            return .requestPlain
        case .manualCheckinGetData(let id):
            return .requestParameters(parameters: ["student_id": id], encoding: URLEncoding.queryString)
        case .manualCheckinSubmitData(let student_id, let classroom_id, let event_id):
            return .requestParameters(
                parameters: ["student_id": student_id, "classroom_id": classroom_id, "event_id": event_id],
                encoding: URLEncoding.queryString
            )
        // Search features
        case .searchStudent(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
            
        // Notifications features
        case .getEvents:
            return .requestPlain
        case .getEventStudents(let event_id):
            return .requestParameters(parameters: ["event_id": event_id], encoding: URLEncoding.queryString)
        case .sendNotifications(let title, let description, let student_ids):
            return .requestParameters(parameters: ["title": title, "description": description, "student_ids": student_ids], encoding: URLEncoding.queryString)
        case .sendNotificationsToAll(let title, let description):
            return .requestParameters(parameters: ["title": title, "description": description], encoding: URLEncoding.queryString)
        case .getClassrooms:
            return .requestPlain
        case .getClassroomStudents(let class_id):
            return .requestParameters(parameters: ["class_id": class_id], encoding: URLEncoding.queryString)
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var authorizationType: AuthorizationType {
        switch self {
            case .login:
                return .none
            default:
                return .bearer
        }
    }
}

protocol Networkable {
    var provider: MoyaProvider<BinhMinhAPI> { get }
    
    // Authorize APIs
    func login(email: String, password: String, completion: @escaping (Response?, Error?) -> ())
    func testConnection(completion: @escaping(Response?, Error?) -> ())
    
    // Bearer APIs
    func getStudentDetail(id: Int, completion: @escaping (Student?, Error?) -> ())
    func autoCheckIn(login_token: String, otp: String, completion: @escaping (CheckInResponse?, Error?) -> ())
    func getAbsentList(completion: @escaping([ClassSections]?, Error?) -> ())
    func manualCheckinGetData(id: Int, completion: @escaping(manualCheckinResponse?, Error?) -> ())
    func manualCheckinSubmitData(student_id: Int, classroom_id: Int, event_id: Int, completion: @escaping(Response?, Error?) -> ())
    
    // Send Notifications APIs
    func getEvents(completion: @escaping([WeekDay]?, Error?) -> ())
    func getEventStudents(event_id: Int, completion: @escaping (EventDetails?, Error?) -> ())
    func sendNotifications(title: String, description: String, student_ids: [Int], completion: @escaping (Response?, Error?) -> ())
    func sendNotificationsToAll(title: String, description: String, completion: @escaping(Response?, Error?) -> ())
    func getClassrooms(completion: @escaping([Classrooms]?, Error?) -> ())
    func getClassrooomStudents(class_id: Int, completion: @escaping (EventDetails?, Error?) -> ())
    
    // Search APIs
    func searchStudent(query: String, completion: @escaping([EventStudents]?, Error?) -> ())
}
