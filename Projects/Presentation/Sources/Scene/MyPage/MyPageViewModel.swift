import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class MyPageViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    private let fetchUserInfoUseCase: FetchUserInfoUseCase
    private let fetchMyNoticeListUseCase: FetchMyNoticeListUseCase

    public init(fetchUserInfoUseCase: FetchUserInfoUseCase, fetchMyNoticeListUseCase: FetchMyNoticeListUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.fetchMyNoticeListUseCase = fetchMyNoticeListUseCase
    }

    public struct Input {
        let viewDidLoad: Signal<Void>
    }
    public struct Output {
        let userInfoData: Driver<UserInfoEntity>
        let myNoticeList: BehaviorRelay<[NoticeEntity]>
    }

    public func transform(_ input: Input) -> Output {
        let userInfoData = BehaviorRelay<UserInfoEntity>(value: .init(accountId: "", name: ""))
        let myNoticeList = BehaviorRelay<[NoticeEntity]>(value: [])
        input.viewDidLoad.asObservable()
            .flatMap { self.fetchUserInfoUseCase.execute() }
            .bind(to: userInfoData)
            .disposed(by: disposeBag)
        input.viewDidLoad.asObservable()
            .flatMap { self.fetchMyNoticeListUseCase.execute() }
            .bind(to: myNoticeList)
            .disposed(by: disposeBag)
        return Output(userInfoData: userInfoData.asDriver(), myNoticeList: myNoticeList)
        
    }
}
