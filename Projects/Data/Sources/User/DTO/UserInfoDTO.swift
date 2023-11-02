import Foundation
import Domain

struct UserInfoDTO: Decodable {
    let accountId, name: String

    enum CodingKeys: String, CodingKey {
        case name
        case accountId = "account_id"
    }
}

extension UserInfoDTO {
    func toDomain() -> UserInfoEntity {
        return .init(
            accountId: accountId,
            name: name
        )
    }
}
