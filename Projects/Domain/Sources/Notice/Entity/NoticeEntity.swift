import Foundation

public struct NoticeEntity: Equatable {
    public let id: String
    public let title: String
    public let createdAt: Date
    public let userAccountId: String
    public let commentCount: Int

    public init(
        id: String,
        title: String,
        createdAt: Date,
        userAccountId: String,
        commentCount: Int
    ) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.userAccountId = userAccountId
        self.commentCount = commentCount
    }
}
