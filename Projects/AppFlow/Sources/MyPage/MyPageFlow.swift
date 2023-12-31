import UIKit
import RxFlow
import Core
import Presentation

public class MyPageFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = BaseNavigationController()
    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .myPageRequire:
            return presentMyPageView()
        default:
            return .none
        }
    }

    private func presentMyPageView() -> FlowContributors {
        let myPageViewController = MyPageViewController(container.myPageViewModel)
        rootViewController.pushViewController(myPageViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: myPageViewController,
            withNextStepper: myPageViewController.viewModel
        ))
    }
}
