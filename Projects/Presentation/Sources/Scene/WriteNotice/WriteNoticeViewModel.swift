import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class WriteNoticeViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let createNoticeUseCase: CreateNoticeUseCase
    
    public init(createNoticeUseCase: CreateNoticeUseCase) {
        self.createNoticeUseCase = createNoticeUseCase
    }

    public struct Input {
        let registerButtonSignal: Signal<Void>
        let titleText: Driver<String>
        let contentText: Driver<String>
    }
    public struct Output {
        let isRegisterAble: Signal<Bool>
    }

    let isRegisterAble = PublishRelay<Bool>()

    public func transform(_ input: Input) -> Output {
        let info = Driver.combineLatest(input.titleText, input.contentText)
        info.asObservable()
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .bind(to: isRegisterAble)
            .disposed(by: disposeBag)
        
        input.registerButtonSignal.asObservable()
            .withLatestFrom(info)
            .flatMap { [self] title, content in
                createNoticeUseCase.execute(title: title, content: content)
                    .andThen(Single.just(PensionStep.noticeRequire))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            isRegisterAble: isRegisterAble.asSignal()
        )
    }
}
