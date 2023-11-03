import Foundation
import RxSwift

public class FetchHousingPensionDetailListUseCase {

    let repository: PensionRepository

    public init(repository: PensionRepository) {
        self.repository = repository
    }

    public func execute(id: String) -> Observable<HousingDetailEntity> {
        return repository.fetchHousingPensionDetailList(id: id)
    }
}
