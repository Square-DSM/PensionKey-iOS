import Foundation
import RxSwift

public class CreateCommentUseCase {

    let repository: CommentRepository

    public init(repository: CommentRepository) {
        self.repository = repository
    }

    public func execute(feedId: String, content: String) -> Completable {
        return repository.createComment(feedId: feedId, content: content)
    }
}
