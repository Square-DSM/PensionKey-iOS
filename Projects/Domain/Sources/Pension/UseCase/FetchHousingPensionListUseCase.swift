import Foundation
import RxSwift

public class FetchHousingPensionListUseCase {

    let repository: PensionRepository

    public init(repository: PensionRepository) {
        self.repository = repository
    }

    public func execute() -> Observable<HousingPensionEntity> {
        return repository.fetchHousingPensionList()
    }
}
