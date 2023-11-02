import Foundation
import Domain
import Core

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
typealias CommentListDTO = [CommentDTO]

extension CommentListDTO {
    func toDomain() -> [CommentEntity] {
        self.map {
            CommentEntity.init(
                id: $0.id,
                content: $0.content,
                userAccountId: $0.userAccountId,
                createdAt: $0.createdAt.toDate(format: .fullDateWithTime)
            )
        }
        
    }
}
