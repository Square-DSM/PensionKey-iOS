import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class MyHousingPensionViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    
    private let fetchHousingPensionDetailListUseCase: FetchHousingPensionDetailListUseCase

    public init(fetchHousingPensionDetailListUseCase: FetchHousingPensionDetailListUseCase) {
        self.fetchHousingPensionDetailListUseCase = fetchHousingPensionDetailListUseCase
    }

    private let housingPensionData = BehaviorRelay<HousingDetailEntity>(value: .init(paymentType: "", expectPension: 0, pensionEndDate: "", managementBranch: ""))

    public struct Input {
        let viewDidAppear: Observable<String>
    }
    public struct Output {
        let housingPensionData: Driver<HousingDetailEntity>
    }

    public func transform(_ input: Input) -> Output {

        input.viewDidAppear.asObservable()
            .flatMap { self.fetchHousingPensionDetailListUseCase.execute(id: $0)}
            .bind(to: housingPensionData)
            .disposed(by: disposeBag)
        
        return Output(housingPensionData: housingPensionData.asDriver())
    }
}
