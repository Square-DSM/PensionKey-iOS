import Foundation
import RxSwift

public class FetchCommentListUseCase {

    let repository: CommentRepository

    public init(repository: CommentRepository) {
        self.repository = repository
    }

    public func execute(feedId: String) -> Single<[CommentEntity]> {
        return repository.fetchCommentList(feedId: feedId)
    }
}
