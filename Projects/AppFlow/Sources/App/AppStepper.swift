import UIKit
import RxFlow
import RxCocoa
import Core

public class AppStepper: Stepper {
    public init() { }

    public var steps = PublishRelay<RxFlow.Step>()

    public func readyToEmitSteps() {
        steps.accept(PensionStep.loginRequire)
    }
}
