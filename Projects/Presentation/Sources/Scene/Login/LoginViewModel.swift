import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class LoginViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let loginUseCase: LoginUseCase
    
    public init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    public struct Input {
        let idText: Driver<String>
        let passwordText: Driver<String>
        let singupButtonDidTap: Signal<Void>
        let loginButotnDidTap: Signal<Void>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        let info = Driver.combineLatest(input.idText, input.passwordText)
        input.singupButtonDidTap.asObservable()
            .map { _ in PensionStep.signupRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.loginButotnDidTap.asObservable()
            .withLatestFrom(info)
            .flatMap { id, password in
                self.loginUseCase.execute(accountID: id, password: password)
                    .andThen(Single.just(PensionStep.tabsRequire))
                    .catchAndReturn(PensionStep.errorRequire)
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
    
