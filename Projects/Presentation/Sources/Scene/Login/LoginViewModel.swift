import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow

public class LoginViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {}

    public struct Input {
        let singupButtonDidTap: Signal<Void>
        let loginButotnDidTap: Signal<Void>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        input.singupButtonDidTap.asObservable()
            .map { _ in PensionStep.signupRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.loginButotnDidTap.asObservable()
            .map { _ in PensionStep.tabsRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
