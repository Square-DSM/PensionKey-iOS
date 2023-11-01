import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class SignupViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let signupUseCase: SignupUseCase

    public init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }

    public struct Input {
        let nameText: Driver<String>
        let idText: Driver<String>
        let passwordText: Driver<String>
        let signupButtonDidTap: Signal<Void>
        let loginButtonDidTap: Signal<Void>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        let info = Driver.combineLatest(input.nameText, input.idText, input.passwordText)
        input.loginButtonDidTap.asObservable()
            .map { _ in PensionStep.loginRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.signupButtonDidTap.asObservable()
            .withLatestFrom(info)
            .flatMap { name, id, password in
                self.signupUseCase.execute(accountID: id, password: password, name: name)
                    .andThen(Single.just(PensionStep.loginRequire))
                    .catchAndReturn(PensionStep.errorRequire)
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
