import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow

public class WriteNoticeViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {}

    public struct Input {
        let registerButtonSignal: Signal<Void>
        let titleDriber: Driver<String>
        let contentsDriber: Driver<String>
    }
    public struct Output {
        let isRegisterAble: Signal<Bool>
    }

    let isRegisterAble = PublishRelay<Bool>()

    public func transform(_ input: Input) -> Output {
        let info = Driver.combineLatest(input.titleDriber, input.contentsDriber)
        info.asObservable()
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .bind(to: isRegisterAble)
            .disposed(by: disposeBag)
        
        input.registerButtonSignal.asObservable()
            .subscribe(onNext: {
                print("등록")
            })
            .disposed(by: disposeBag)

        return Output(
            isRegisterAble: isRegisterAble.asSignal()
        )
    }
}
