import Foundation
import RxSwift

public class CreateNoticeUseCase {

    let repository: NoticeRepository

    public init(repository: NoticeRepository) {
        self.repository = repository
    }

    public func execute(title: String, content: String) -> Completable {
        return repository.createNotice(title: title, content: content)
    }
}
