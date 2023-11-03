import Foundation
import RxSwift
import Domain
import AppNetwork
import Core
import Moya

class PensionRepositoryImpl: PensionRepository {

    let remoteDataSource = PensionDataSource.shared

    func fetchNationalPensionList() -> Observable<NationalPensionEntity> {
        remoteDataSource.fetchNationalPensionList()
            .asObservable()
    }
    
    func fetchHousingPensionList() -> Observable<HousingPensionEntity> {
        remoteDataSource.fetchHousingPensionList()
            .asObservable()
    }
    
    func fetchPersonalPensionList() -> Observable<PersonalPensionEntity> {
        remoteDataSource.fetchPersonalPensionList()
            .asObservable()
    }

    func fetchNationalPensionDetailList() -> Observable<NationalDetailEntity> {
        remoteDataSource.fetchNationalPensionDetailList()
            .asObservable()
    }
    
    func fetchHousingPensionDetailList(id: String) -> Observable<HousingDetailEntity> {
        remoteDataSource.fetchHousingPensionDetailList(id: id)
            .asObservable()
    }
    
    func fetchPersonalPensionDetailList(id: String) -> Observable<PersonalDetailEntity> {
        remoteDataSource.fetchPersonalPensionDetailList(id: id)
            .asObservable()
    }
}
