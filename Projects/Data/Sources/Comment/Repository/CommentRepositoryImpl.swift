import Foundation
import RxSwift
import Domain
import AppNetwork
import Core
import Moya

class CommentRepositoryImpl: CommentRepository {
    let commentDataSource = CommentDataSource.shared
    private var disposeBag = DisposeBag()

    func fetchCommentList(feedId: String) -> Single<[CommentEntity]> {
        commentDataSource.fetchCommentList(feedId: feedId)
    }
    func createComment(feedId: String, content: String) -> Completable {
        commentDataSource.createComment(feedId: feedId, content: content)
    }
}
