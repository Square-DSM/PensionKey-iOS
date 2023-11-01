import Foundation
import Domain

struct CommentDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case userAccountId = "user_account_id"
    }

    let id: String
    let content: String
    let userAccountId: String
}

extension CommentDTO {
    func toDomain() -> CommentEntity {
        CommentEntity.init(
            id: self.id,
            content: self.content,
            userAccountId: self.userAccountId
        )
        
    }
}
