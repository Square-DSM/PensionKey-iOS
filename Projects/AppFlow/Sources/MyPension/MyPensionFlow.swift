import UIKit
import RxFlow
import Core
import Presentation

public class MyPensionFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = UINavigationController()

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .myPensionRequire:
            return presentMyPensionView()
        case .myPensionDetailRequire:
            return presentMyPensionDetailView()
        default:
            return .none
        }
    }

    private func presentMyPensionView() -> FlowContributors {
        let myPensionViewController = MyPensionViewController()
        rootViewController.pushViewController(myPensionViewController, animated: false)
        return .one(flowContributor: .contribute(withNext: myPensionViewController)
        )
    }

    private func presentMyPensionDetailView() -> FlowContributors {
        let myPensionDetailViewController = MyPensionDetailViewController()
        rootViewController.pushViewController(myPensionDetailViewController, animated: true)
        return .one(flowContributor: .contribute(withNext: myPensionDetailViewController)
        )
    }
}
