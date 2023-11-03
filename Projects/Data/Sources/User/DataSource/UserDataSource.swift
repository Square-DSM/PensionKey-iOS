import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger
import Domain

class UserDataSource {

    private let provider = MoyaProvider<UserAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = UserDataSource()
    private init() {}

    func fetchUserInfo() -> Single<UserInfoEntity> {
        provider.rx.request(.fetchUserInfo)
            .map(UserInfoDTO.self)
            .map { $0.toDomain() }
    }
}
