import Foundation
import RxSwift

public class SearchNoticeListUseCase {

    let repository: NoticeRepository

    public init(repository: NoticeRepository) {
        self.repository = repository
    }

    public func execute(keyword: String) -> Single<[NoticeEntity]> {
        return repository.searchNoticeList(keyword: keyword)
    }
}
