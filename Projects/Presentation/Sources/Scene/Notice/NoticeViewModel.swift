import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow

public class NoticeViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {}

    public struct Input {
        let writeNotcieButtonDidTap: Signal<Void>
        let searchButtonDidTap: Signal<Void>
        let noticeTableViewCellDidTap: ControlEvent<IndexPath>
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        input.writeNotcieButtonDidTap.asObservable()
            .map { _ in PensionStep.writeNoticeRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.noticeTableViewCellDidTap.asObservable()
            .map { _ in PensionStep.noticeDetailRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.searchButtonDidTap.asObservable()
            .map { PensionStep.searchRequire }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
