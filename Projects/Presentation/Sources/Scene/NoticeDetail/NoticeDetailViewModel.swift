import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class NoticeDetailViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let fetchNoticeDetailUseCase: FetchNoticeDetailUseCase
    
    public init(fetchNoticeDetailUseCase: FetchNoticeDetailUseCase) {
        self.fetchNoticeDetailUseCase = fetchNoticeDetailUseCase
    }

    public struct Input {
        let id: String
        let viewAppear: Signal<Void>
        let deletePostButtonDidClick: Signal<Void>
        let editPostButtonDidClick: Signal<Void>
    }
    public struct Output {
        let noticeDetailData: BehaviorRelay<NoticeDetailEntity>
    }

    public func transform(_ input: Input) -> Output {
        let noticeDetailData = BehaviorRelay<NoticeDetailEntity>(value: .init(
            id: "",
            title: "",
            content: "",
            createdAt: "",
            userAccountId: "",
            commentList: []
        ))
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
        input.viewAppear.asObservable()
            .flatMap { self.fetchNoticeDetailUseCase.execute(feedId: input.id) }
            .bind(to: noticeDetailData)
            .disposed(by: disposeBag)
        return Output(noticeDetailData: noticeDetailData)
    }
}
