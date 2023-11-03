import Foundation
import RxSwift

public class FetchNationalPensionListUseCase {

    let repository: PensionRepository

    public init(repository: PensionRepository) {
        self.repository = repository
    }

    public func execute() -> Observable<NationalPensionEntity> {
        return repository.fetchNationalPensionList()
    }
}
