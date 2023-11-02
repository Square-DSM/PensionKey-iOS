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

    public init(fetchUserInfoUseCase: FetchUserInfoUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }

    public struct Input {
        let viewDidLoad: Signal<Void>
    }
    public struct Output {
        let UserInfoData: Driver<UserInfoEntity>
    }

    public func transform(_ input: Input) -> Output {
        let userInfoData = BehaviorRelay<UserInfoEntity>(value: .init(accountId: "", name: ""))

        input.viewDidLoad.asObservable()
            .flatMap { self.fetchUserInfoUseCase.execute() }
            .bind(to: userInfoData)
            .disposed(by: disposeBag)
        
        return Output(UserInfoData: userInfoData.asDriver())
        
    }
}
