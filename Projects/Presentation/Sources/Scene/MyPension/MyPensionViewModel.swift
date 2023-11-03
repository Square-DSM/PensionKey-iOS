import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class MyPensionViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let fetchNationalPensionListUseCase: FetchNationalPensionListUseCase
    private let fetchHousingPensionListUseCase: FetchHousingPensionListUseCase
    private let fetchPersonalPensionListUseCase: FetchPersonalPensionListUseCase
    private let fetchUserInfoUseCase: FetchUserInfoUseCase

    public init(
        fetchNationalPensionListUseCase: FetchNationalPensionListUseCase,
        fetchHousingPensionListUseCase: FetchHousingPensionListUseCase,
        fetchPersonalPensionListUseCase: FetchPersonalPensionListUseCase,
        fetchUserInfoUseCase: FetchUserInfoUseCase
    ) {
        self.fetchNationalPensionListUseCase = fetchNationalPensionListUseCase
        self.fetchHousingPensionListUseCase = fetchHousingPensionListUseCase
        self.fetchPersonalPensionListUseCase = fetchPersonalPensionListUseCase
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }

    let nationalRelay = PublishRelay<NationalPensionEntity>()
    let personalRelay = PublishRelay<PersonalPensionEntity>()
    let housingRelay = PublishRelay<HousingPensionEntity>()
    let userRelay = PublishRelay<UserInfoEntity>()

    public struct Input {
        let isSelectedNationalCell: ControlEvent<IndexPath>
        let isSelectedPersonalCell: Observable<String>
        let isSelectedHousingCell: Observable<String>
        let viewDidLoad: Observable<Void>
    }
    public struct Output {
        let nationalData: Signal<NationalPensionEntity>
        let personalData: Signal<PersonalPensionEntity>
        let housingData: Signal<HousingPensionEntity>
        let userData: Signal<UserInfoEntity>
    }

    public func transform(_ input: Input) -> Output {
        input.isSelectedNationalCell.asObservable()
            .map { _ in PensionStep.myNationalPensionDetailRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.isSelectedPersonalCell.asObservable()
            .map { PensionStep.myPersonalPensionDetailRequire(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.isSelectedHousingCell.asObservable()
            .map { PensionStep.myHousingPensionDetailRequire(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.viewDidLoad.asObservable()
            .flatMap {
                self.fetchNationalPensionListUseCase.execute()
            }
            .bind(to: nationalRelay)
            .disposed(by: disposeBag)

        input.viewDidLoad.asObservable()
            .flatMap {
                self.fetchPersonalPensionListUseCase.execute()
            }
            .bind(to: personalRelay)
            .disposed(by: disposeBag)

        input.viewDidLoad.asObservable()
            .flatMap {
                self.fetchHousingPensionListUseCase.execute()
            }
            .bind(to: housingRelay)
            .disposed(by: disposeBag)

        input.viewDidLoad.asObservable()
            .flatMap {
                self.fetchUserInfoUseCase.execute()
            }
            .bind(to: userRelay)
            .disposed(by: disposeBag)
        return Output(
            nationalData: nationalRelay.asSignal(),
            personalData: personalRelay.asSignal(),
            housingData: housingRelay.asSignal(),
            userData: userRelay.asSignal()
        )
    }
}
