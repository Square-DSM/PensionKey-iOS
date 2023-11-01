import Foundation
import Domain

struct NoticeDetailDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case content
    }

    let title: String
    let content: String
}

extension NoticeDetailDTO {
    func toDomain() -> NoticeDetailEntity {
        return NoticeDetailEntity(title: self.title, content: self.content)
    }
}
