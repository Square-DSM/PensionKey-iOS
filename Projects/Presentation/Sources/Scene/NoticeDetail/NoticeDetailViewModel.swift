import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow

public class NoticeDetailViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {}

    public struct Input {
        let deletePostButtonDidClick: Signal<Void>
        let editPostButtonDidClick: Signal<Void>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        input.deletePostButtonDidClick.asObservable()
            .subscribe(onNext: {
                print("게시물 삭제")
            })
            .disposed(by: disposeBag)

        input.editPostButtonDidClick.asObservable()
            .subscribe(onNext: {
                print("게시물 수정")
            })
            .disposed(by: disposeBag)
        return Output()
    }
}
