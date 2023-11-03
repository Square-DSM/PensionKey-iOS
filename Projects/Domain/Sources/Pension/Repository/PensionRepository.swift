import Foundation
import RxSwift

public protocol PensionRepository {
    func fetchNationalPensionList() -> Observable<NationalPensionEntity>
    func fetchHousingPensionList() -> Observable<HousingPensionEntity>
    func fetchPersonalPensionList() -> Observable<PersonalPensionEntity>

    func fetchNationalPensionDetailList() -> Observable<NationalDetailEntity>
    func fetchHousingPensionDetailList(id: String) -> Observable<HousingDetailEntity>
    func fetchPersonalPensionDetailList(id: String) -> Observable<PersonalDetailEntity>
}
