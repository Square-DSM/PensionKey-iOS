import Foundation

public struct NoticeDetailEntity: Equatable {
    public let id: String
    public let title: String
    public let content: String
    public let createdAt: String
    public let userAccountId: String
    public let commentList: [CommentEntity]

    public init(id: String, title: String, content: String, createdAt: String, userAccountId: String, commentList: [CommentEntity]) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.userAccountId = userAccountId
        self.commentList = commentList
    }
}
