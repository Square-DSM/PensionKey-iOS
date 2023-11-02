import Foundation
import RxSwift

public class FetchUserInfoUseCase {

    let repository: UserRepository

    public init(repository: UserRepository) {
        self.repository = repository
    }

    public func execute() -> Single<UserInfoEntity> {
        return repository.fetchUserInfo()
    }
}
