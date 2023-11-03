import Foundation

public struct UserInfoEntity {
    public let accountId, name: String

    public init(accountId: String, name: String) {
        self.accountId = accountId
        self.name = name
    }
}
