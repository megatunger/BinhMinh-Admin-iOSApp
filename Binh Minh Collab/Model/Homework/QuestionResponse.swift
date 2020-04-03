// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let questionResponse = try? newJSONDecoder().decode(QuestionResponse.self, from: jsonData)

import Foundation

// MARK: - QuestionResponse
struct QuestionResponse: Codable {
    let status, message: String?
    let question: Question?
    
    init() {
        status = ""
        message = ""
        question = nil
    }
}

// MARK: - Question
struct Question: Codable {
    let id, testExamID: Int?
    let questionURL: String?
    let question_hash: String?

    enum CodingKeys: String, CodingKey {
        case id
        case testExamID = "test_exam_id"
        case questionURL = "question_url"
        case question_hash = "question_hash"
    }
}
