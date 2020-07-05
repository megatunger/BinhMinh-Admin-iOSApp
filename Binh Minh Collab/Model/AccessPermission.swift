import Foundation

// MARK: - AccessPermission
struct AccessPermission: Codable {
    let accountType: String?
    let permissions: [Permission]?

    enum CodingKeys: String, CodingKey {
        case accountType = "account_type"
        case permissions
    }
}

// MARK: - Permission
struct Permission: Codable {
    let key: String?
    let value: Bool?
}
