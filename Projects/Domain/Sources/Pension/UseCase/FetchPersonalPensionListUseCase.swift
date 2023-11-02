import Foundation
import RxSwift

public class FetchPersonalPensionListUseCase {

    let repository: PensionRepository

    public init(repository: PensionRepository) {
        self.repository = repository
    }

    public func execute() -> Observable<PersonalPensionEntity> {
        return repository.fetchPersonalPensionList()
    }
}
