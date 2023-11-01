import Foundation
import Domain

struct NoticeDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case createdAt = "created_at"
        case userAccountId = "user_account_id"
    }
    let id: String
    let title: String
    let createdAt: String
    let userAccountId: String
}
//typealias NoticeListDTO: [NoticeDTO]

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
                createdAt: $0.createdAt,
                userAccountId: $0.userAccountId
            )
        }
    }
}
