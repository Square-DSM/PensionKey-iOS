import Foundation
import RxSwift

public protocol PensionRepository {
    func fetchNationalPensionList() -> Observable<NationalPensionEntity> // Entity
    func fetchHousingPensionList() -> Observable<HousingPensionEntity>
    func fetchPersonalPensionList() -> Observable<PersonalPensionEntity>

    func fetchNationalPensionDetailList() -> Observable<NationalDetailEntity>
    func fetchHousingPensionDetailList(id: String) -> Observable<HousingDetailEntity>
    func fetchPersonalPensionDetailList(id: String) -> Observable<PersonalDetailEntity>
}
