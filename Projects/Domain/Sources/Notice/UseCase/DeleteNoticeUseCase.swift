import Foundation
import RxSwift

public class DeleteNoticeUseCase {

    let repository: NoticeRepository

    public init(repository: NoticeRepository) {
        self.repository = repository
    }

    public func execute(feedId: String) -> Completable {
        return repository.deleteNotice(feedID: feedId)
    }
}
