import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class NoticeViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let fetchNoticeListUseCase: FetchNoticeListUseCase
    
    public init(fetchNoticeListUseCase: FetchNoticeListUseCase) {
        self.fetchNoticeListUseCase = fetchNoticeListUseCase
    }

    public struct Input {
        let viewAppear: Signal<Void>
        let writeNotcieButtonDidTap: Signal<Void>
        let searchButtonDidTap: Signal<Void>
        let noticeTableViewCellDidTap: ControlEvent<IndexPath>
    }
    public struct Output {
        let noticeList: BehaviorRelay<[NoticeEntity]>
    }

    public func transform(_ input: Input) -> Output {
        let noticeList = BehaviorRelay<[NoticeEntity]>(value: [])
        input.viewAppear.asObservable()
            .flatMap { [self] in
                fetchNoticeListUseCase.execute()
            }
            .bind(to: noticeList)
            .disposed(by: disposeBag)
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
        return Output(noticeList: noticeList)
    }
}
