import Foundation
import RxSwift

public class FetchNoticeDetailUseCase {

    let repository: NoticeRepository

    public init(repository: NoticeRepository) {
        self.repository = repository
    }

    public func execute(feedId: String) -> Single<NoticeDetailEntity> {
        return repository.fetchNoticeDetail(feedId: feedId)
    }
}
