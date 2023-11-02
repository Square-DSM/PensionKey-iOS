import Foundation

public struct NoticeDetailEntity: Equatable {
    public let id: String
    public let title: String
    public let content: String
    public let createdAt: Date
    public let userAccountId: String

    public init(id: String, title: String, content: String, createdAt: Date, userAccountId: String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.userAccountId = userAccountId
    }
}
