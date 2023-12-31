import UIKit
import RxFlow
import Core
import Presentation

public class SignupFlow: Flow {

    public var root: Presentable {
        return presentalbeView
    }

    let presentalbeView: SignupViewController
    public init() {
        self.presentalbeView = SignupViewController(container.signupViewModel)
    }
    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .loginRequire:
            return presentLoginView()
        case .signupRequire:
            return presentSignupView()
        case .errorRequire:
            return presentError(view: self.presentalbeView)
        default:
            return .none
        }
    }

    private func presentLoginView() -> FlowContributors {
        self.presentalbeView.navigationController?.popViewController(animated: true)
        return .none
    }

    private func presentSignupView() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: presentalbeView,
            withNextStepper: presentalbeView.viewModel
        ))
    }
}
