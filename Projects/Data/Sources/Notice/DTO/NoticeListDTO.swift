import Foundation
import Domain
import Core

struct NoticeDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case createdAt = "created_at"
        case userAccountId = "user_account_id"
        case commentCount = "comment_count"
    }
    let id: String
    let title: String
    let createdAt: String
    let userAccountId: String
    let commentCount: Int
}

struct NoticeListDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case feedList = "feed_list"
    }
    let feedList: [NoticeDTO]
}

extension NoticeListDTO {
    func toDomain() -> [NoticeEntity] {
        feedList.map {
            NoticeEntity.init(
                id: $0.id,
                title: $0.title,
                createdAt: $0.createdAt.toDate(format: .fullDateWithTime),
                userAccountId: $0.userAccountId,
                commentCount: $0.commentCount
            )
        }
    }
}
