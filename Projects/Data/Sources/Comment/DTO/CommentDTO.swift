import Foundation
import Domain

struct CommentDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case userAccountId = "user_account_id"
        case createdAt = "created_at"
    }

    let id: String
    let content: String
    let userAccountId: String
    let createdAt: String
}

extension CommentDTO {
    func toDomain() -> CommentEntity {
        CommentEntity.init(
            id: self.id,
            content: self.content,
            userAccountId: self.userAccountId,
            createdAt: self.createdAt
        )
        
    }
}
