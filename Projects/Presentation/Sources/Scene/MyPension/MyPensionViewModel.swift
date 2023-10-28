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
        let isSelectedCollectionViewCell: ControlEvent<IndexPath>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        input.isSelectedCollectionViewCell.asObservable()
            .map { _ in PensionStep.myPensionDetailRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
