import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow

public class MyPensionViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {}

    public struct Input {
        let isSelectedNationalCell: ControlEvent<IndexPath>
        let isSelectedPersonalCell: ControlEvent<IndexPath>
        let isSelectedHousingCell: ControlEvent<IndexPath>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        input.isSelectedNationalCell.asObservable()
            .map { _ in PensionStep.myNationalPensionDetailRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.isSelectedPersonalCell.asObservable()
            .map { _ in PensionStep.myPersonalPensionDetailRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.isSelectedHousingCell.asObservable()
            .map { _ in PensionStep.myHousingPensionDetailRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
