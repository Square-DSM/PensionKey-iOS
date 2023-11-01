import UIKit
import Core
import RxSwift
import RxCocoa
import RxFlow

public class MyPersonalPensionViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    public init() {}

    public struct Input {
    }
    public struct Output {
    }

    public func transform(_ input: Input) -> Output {
        return Output()
    }
}
