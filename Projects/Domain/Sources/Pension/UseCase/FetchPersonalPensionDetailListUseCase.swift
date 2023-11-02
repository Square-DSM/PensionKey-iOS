import Foundation
import RxSwift

public class FetchPersonalPensionDetailListUseCase {

    let repository: PensionRepository

    public init(repository: PensionRepository) {
        self.repository = repository
    }

    public func execute(id: String) -> Observable<PersonalDetailEntity> {
        return repository.fetchPersonalPensionDetailList(id: id)
    }
}
