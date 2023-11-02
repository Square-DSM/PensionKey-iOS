import Foundation
import RxSwift

public protocol UserRepository {
    func fetchUserInfo() -> Single<UserInfoEntity>
}
