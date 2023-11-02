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
    private let fetchCommentListUseCase: FetchCommentListUseCase
    private let createCommentUseCase: CreateCommentUseCase
    private let deleteNoticeUseCase: DeleteNoticeUseCase

    
    public init(
        fetchNoticeDetailUseCase: FetchNoticeDetailUseCase,
        fetchCommentListUseCase: FetchCommentListUseCase,
        createCommentUseCase: CreateCommentUseCase,
        deleteNoticeUseCase: DeleteNoticeUseCase
    ) {
        self.fetchNoticeDetailUseCase = fetchNoticeDetailUseCase
        self.fetchCommentListUseCase = fetchCommentListUseCase
        self.createCommentUseCase = createCommentUseCase
        self.deleteNoticeUseCase = deleteNoticeUseCase
    }

    public struct Input {
        let id: String
        let viewAppear: Signal<Void>
        let commentText: Driver<String>
        let deletePostButtonDidClick: Signal<Void>
        let commentRegisterButtonDidTap: Signal<Void>
    }
    public struct Output {
        let noticeDetailData: BehaviorRelay<NoticeDetailEntity>
        let commentListData: BehaviorRelay<[CommentEntity]>
        let reloadView: PublishRelay<Void>
        let isEmpty: PublishRelay<Bool>
    }

    public func transform(_ input: Input) -> Output {
        let noticeDetailData = BehaviorRelay<NoticeDetailEntity>(value: .init(
            id: "",
            title: "",
            content: "",
            createdAt: Date(),
            userAccountId: ""
        ))
        let commentListData = BehaviorRelay<[CommentEntity]>(value: [])
        let reloadView = PublishRelay<Void>()
        let isEmpty = PublishRelay<Bool>()
        input.commentText.asObservable()
            .map { !$0.isEmpty }
            .bind(to: isEmpty)
            .disposed(by: disposeBag)
        input.deletePostButtonDidClick.asObservable()
            .flatMap {
                self.deleteNoticeUseCase.execute(feedId: input.id)
                    .andThen(Single.just(PensionStep.noticeRequire))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.viewAppear.asObservable()
            .flatMap { self.fetchNoticeDetailUseCase.execute(feedId: input.id) }
            .bind(to: noticeDetailData)
            .disposed(by: disposeBag)
        
        input.viewAppear.asObservable()
            .flatMap { self.fetchCommentListUseCase.execute(feedId: input.id) }
            .map { $0.sorted(by: { $0.createdAt > $1.createdAt }) }
            .bind(to: commentListData)
            .disposed(by: disposeBag)
        input.commentRegisterButtonDidTap.asObservable()
            .withLatestFrom(input.commentText)
            .filter { !$0.isEmpty }
            .flatMap { content in
                self.createCommentUseCase.execute(feedId: input.id, content: content)
                    .andThen(Single.just(()))
            }
            .bind(to: reloadView)
            .disposed(by: disposeBag)
            
        return Output(noticeDetailData: noticeDetailData, commentListData: commentListData, reloadView: reloadView, isEmpty: isEmpty)
    }
}
