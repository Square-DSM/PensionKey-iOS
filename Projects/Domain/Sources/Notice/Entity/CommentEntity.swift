import Foundation

public struct CommentEntity: Equatable {
    public let id: String
    public let content: String
    public let userAccountId: String

    public init(id: String, content: String, userAccountId: String) {
        self.id = id
        self.content = content
        self.userAccountId = userAccountId
    }
}
