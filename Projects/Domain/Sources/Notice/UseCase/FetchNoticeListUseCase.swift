import Foundation
import RxSwift

public class FetchNoticeListUseCase {

    let repository: NoticeRepository

    public init(repository: NoticeRepository) {
        self.repository = repository
    }

    public func execute() -> Single<[NoticeEntity]> {
        return repository.fetchNoticeList()
    }
}
