import UIKit
import RxFlow
import Core
import Presentation

public class LoginFlow: Flow {

    public var root: Presentable {
        return presentalbeView
    }

    let presentalbeView = UINavigationController()
    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .loginRequire:
            return presentLoginView()
        case .signupRequire:
            return presentSignupView()
        case .tabsRequire:
            return .end(forwardToParentFlowWithStep: PensionStep.tabsRequire)
        case .errorRequire:
            return presentError(view: self.presentalbeView)
        default:
            return .none
        }
    }

    private func presentLoginView() -> FlowContributors {
        let loginViewController = LoginViewController(container.loginViewModel)
        presentalbeView.pushViewController(loginViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: loginViewController,
            withNextStepper: loginViewController.viewModel
        ))
    }
    
    private func presentSignupView() -> FlowContributors {
        let signupFlow = SignupFlow()
        Flows.use(signupFlow, when: .created) { root in
            self.presentalbeView.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: signupFlow,
            withNextStepper: OneStepper(withSingleStep: PensionStep.signupRequire)
        ))
    }
}
