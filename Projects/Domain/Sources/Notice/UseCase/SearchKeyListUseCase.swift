import Foundation
import RxSwift

public class SearchKeyListUseCase {

    let repository: NoticeRepository

    public init(repository: NoticeRepository) {
        self.repository = repository
    }

    public func execute() -> Single<[SearchKeyEntity]> {
        return repository.searchKeyList()
    }
}
