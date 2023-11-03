import Foundation
import RxSwift

public class FetchMyNoticeListUseCase {

    let repository: NoticeRepository

    public init(repository: NoticeRepository) {
        self.repository = repository
    }

    public func execute() -> Single<[NoticeEntity]> {
        return repository.fetchMyNoticeList()
    }
}
