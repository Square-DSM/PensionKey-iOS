import UIKit
import RxFlow
import Core
import Presentation

public class LoginFlow: Flow {

    public var root: Presentable {
        return presentalbeView
    }

    let presentalbeView = UINavigationController()

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .loginRequire:
            return presentLoginView()
        default:
            return .none
        }
    }

    private func presentLoginView() -> FlowContributors {
        presentalbeView.pushViewController(FirstViewController(), animated: false)
        return .none
    }
}
