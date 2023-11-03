import Foundation
import RxSwift
import Domain

class UserRepositoryImpl: UserRepository {

    let remoteDataSource = UserDataSource.shared
    
    func fetchUserInfo() -> Single<UserInfoEntity> {
        return remoteDataSource.fetchUserInfo()
    }
}
