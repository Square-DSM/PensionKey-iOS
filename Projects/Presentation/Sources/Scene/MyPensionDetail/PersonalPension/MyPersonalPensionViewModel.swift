import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class MyPersonalPensionViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let FetchPersonalPensionDetailListUseCase: FetchPersonalPensionDetailListUseCase

    public init(FetchPersonalPensionDetailListUseCase: FetchPersonalPensionDetailListUseCase) {
        self.FetchPersonalPensionDetailListUseCase = FetchPersonalPensionDetailListUseCase
    }

    private let personalPensionData = BehaviorRelay<PersonalDetailEntity>(value: .init(
        companyName: "", productName: "", totalPaymentAmt: 0, expectPension: 0))

    public struct Input {
        let viewDidAppear: Observable<String>
    }
    public struct Output {
        let personalPensionData: Driver<PersonalDetailEntity>
    }

    public func transform(_ input: Input) -> Output {
        input.viewDidAppear.asObservable()
            .flatMap { self.FetchPersonalPensionDetailListUseCase.execute(id: $0) }
            .bind(to: personalPensionData)
            .disposed(by: disposeBag)

        return Output(personalPensionData: personalPensionData.asDriver())
    }
}
