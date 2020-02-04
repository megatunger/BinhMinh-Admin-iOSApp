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
    case getStudentDetail(id: Int)
    case autoCheckIn(login_token: String, otp: String)
    case getAbsentList
    case manualCheckinGetData(id: Int)
    case manualCheckinSubmitData(student_id: Int, classroom_id: Int, event_id: Int)
}

extension BinhMinhAPI: TargetType {
    
    public var baseURL: URL { return URL(string: Constant.baseURL+"/api/v2/admin")!}
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    public var path: String {
        switch self {
        case .getStudentDetail(let id):
            return "/students/\(id).json"
        case .autoCheckIn( _, _):
            return "/check-in"
        case .getAbsentList:
            return "/get_absent_list.json"
        case .manualCheckinGetData(let id):
            return "/manualCheckin/\(id).json"
        case .manualCheckinSubmitData:
            return "/manualCheckin.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
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
        case .getStudentDetail:
            return .requestPlain
        case .autoCheckIn(let login_token, let otp):
            return .requestParameters(parameters: ["login_token" : login_token, "otp" : otp], encoding: URLEncoding.queryString)
        case .getAbsentList:
            return .requestPlain
        case .manualCheckinGetData:
            return .requestPlain
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
}

protocol Networkable {
    var provider: MoyaProvider<BinhMinhAPI> { get }
    func getStudentDetail(id: Int, completion: @escaping (Student?, Error?) -> ())
    func autoCheckIn(login_token: String, otp: String, completion: @escaping (CheckInResponse?, Error?) -> ())
    func getAbsentList(completion: @escaping([Section]?, Error?) -> ())
    func manualCheckinGetData(id: Int, completion: @escaping(manualCheckinResponse?, Error?) -> ())
    func manualCheckinSubmitData(student_id: Int, classroom_id: Int, event_id: Int, completion: @escaping(manualCheckinSubmitResponse?, Error?) -> ())
}
