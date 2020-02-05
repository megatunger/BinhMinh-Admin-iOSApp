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
    
    func getStudentDetail(id: Int, completion: @escaping (Student?, Error?) -> ())
    func autoCheckIn(login_token: String, otp: String, completion: @escaping (CheckInResponse?, Error?) -> ())
    func getAbsentList(completion: @escaping([Section]?, Error?) -> ())
    func manualCheckinGetData(id: Int, completion: @escaping(manualCheckinResponse?, Error?) -> ())
    func manualCheckinSubmitData(student_id: Int, classroom_id: Int, event_id: Int, completion: @escaping(Response?, Error?) -> ())
}
