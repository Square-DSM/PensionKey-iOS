import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger
import Domain

class CommentDataSource {

    private let provider = MoyaProvider<CommentAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = CommentDataSource()
    private init() {}

    func fetchCommentList(feedId: String) -> Single<[CommentEntity]> {
        return provider.rx.request(.fetchCommentList(feedId: feedId))
            .map(CommentListDTO.self)
            .map { $0.toDomain() }
    }
    func createComment(feedId: String, content: String) -> Completable {
        return provider.rx.request(.createComment(feedId: feedId, content: content))
            .asCompletable()
    }
}
