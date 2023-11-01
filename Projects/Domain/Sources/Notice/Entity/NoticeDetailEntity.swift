import Foundation

public struct NoticeDetailEntity: Equatable {
    public let id: String
    public let title: String
    public let content: String
    public let createdAt: String
    public let userAccountId: String

    public init(id: String, title: String, content: String, createdAt: String, userAccountId: String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.userAccountId = userAccountId
    }
}
