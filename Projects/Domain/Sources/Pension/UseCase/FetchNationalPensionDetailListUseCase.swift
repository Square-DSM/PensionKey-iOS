import Foundation
import RxSwift

public class FetchNationalPensionDetailListUseCase {

    let repository: PensionRepository

    public init(repository: PensionRepository) {
        self.repository = repository
    }

    public func execute() -> Observable<NationalDetailEntity> {
        return repository.fetchNationalPensionDetailList()
    }
}
