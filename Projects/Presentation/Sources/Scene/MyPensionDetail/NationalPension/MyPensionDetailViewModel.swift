import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow
import Domain

public class MyNationalPensionDetailViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    let fetchNationalPensionDetailListUseCase: FetchNationalPensionDetailListUseCase

    public init(fetchNationalPensionDetailListUseCase: FetchNationalPensionDetailListUseCase) {
        self.fetchNationalPensionDetailListUseCase = fetchNationalPensionDetailListUseCase
    }

    let detailData = PublishRelay<NationalDetailEntity>()

    public struct Input {
        let viewDidLoad: Observable<Void>
    }
    public struct Output {
        let detailData: Signal<NationalDetailEntity>
    }

    public func transform(_ input: Input) -> Output {
        input.viewDidLoad.asObservable()
            .flatMap {
                self.fetchNationalPensionDetailListUseCase.execute()
            }
            .bind(to: detailData)
            .disposed(by: disposeBag)

        return Output(detailData: detailData.asSignal())
    }
}
