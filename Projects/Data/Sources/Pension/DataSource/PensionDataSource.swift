import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger
import Domain

class PensionDataSource {

    private let provider = MoyaProvider<PensionAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = PensionDataSource()
    private init() {}

    func fetchNationalPensionList() -> Single<NationalPensionEntity> {
        provider.rx.request(.fetchNationalPensionList)
            .map(NationalPensionDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchHousingPensionList() -> Single<HousingPensionEntity> {
        provider.rx.request(.fetchHousingPensionList)
            .map(HousingPensionDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchPersonalPensionList() -> Single<PersonalPensionEntity> {
        provider.rx.request(.fetchPersonalPensionList)
            .map(PersonalPensionDTO.self)
            .map { $0.toDomain() }
    }

    func fetchNationalPensionDetailList() -> Single<NationalDetailEntity> {
        provider.rx.request(.fetchNationalPensionDetailList)
            .map(NationalDetailDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchHousingPensionDetailList(id: String) -> Single<HousingDetailEntity> {
        provider.rx.request(.fetchHousingPensionDetailList(id: id))
            .map(HousingDetailDTO.self)
            .map { $0.toDomain() }
    }
    
    func fetchPersonalPensionDetailList(id: String) -> Single<PersonalDetailEntity> {
        provider.rx.request(.fetchPersonalPensionDetailList(id: id))
            .map(PersonalDetailDTO.self)
            .map { $0.toDomain() }
    }
}
