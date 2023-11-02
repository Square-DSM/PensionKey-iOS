import Foundation
import Domain

struct NoticeDetailDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at"
        case userAccountId = "user_account_id"
    }

    let id: String
    let title: String
    let content: String
    let createdAt: String
    let userAccountId: String
}

extension NoticeDetailDTO {
    func toDomain() -> NoticeDetailEntity {
        return NoticeDetailEntity(
            id: self.id,
            title: self.title,
            content: self.content,
            createdAt: self.createdAt,
            userAccountId: self.userAccountId
        )
    }
}