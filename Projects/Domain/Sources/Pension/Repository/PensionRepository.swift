import Foundation
import RxSwift

public protocol PensionRepository {
    func fetchNationalPensionList() -> Completable // Entity
    func fetchHousingPensionList() -> Completable
    func fetchPersonalPensionList() -> Completable

    func fetchNationalPensionDetailList() -> Completable
    func fetchHousingPensionDetailList() -> Completable
    func fetchPersonalPensionDetailList() -> Completable
}
