import Foundation
import RxSwift

public protocol CommentRepository {
    func fetchCommentList(feedId: String) -> Single<[CommentEntity]>
    func createComment(feedId: String, content: String) -> Completable
}
