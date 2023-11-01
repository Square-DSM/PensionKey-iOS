import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow

public class SignupViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {}

    public struct Input {
        let loginButtonDidTap: Signal<Void>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        input.loginButtonDidTap.asObservable()
            .map { _ in PensionStep.loginRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
