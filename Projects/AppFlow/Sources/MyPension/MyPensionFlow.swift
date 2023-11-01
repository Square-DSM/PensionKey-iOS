import UIKit
import RxFlow
import Core
import Presentation

public class MyPensionFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = BaseNavigationController()

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
        let myPensionViewController = MyPensionViewController(MyPensionViewModel())
        rootViewController.pushViewController(myPensionViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: myPensionViewController,
            withNextStepper: myPensionViewController.viewModel
        ))
    }

    private func presentMyPensionDetailView() -> FlowContributors {
        let myNationalPensionDetailViewController = MyNationalPensionDetailViewController(MyNationalPensionDetailViewModel())
        let myPersonalPensionViewController = MyPersonalPensionViewController(MyPersonalPensionViewModel())
        let myHousingPensionViewController = MyHousingPensionViewController(MyHousingPensionViewModel())
        rootViewController.pushViewController(myHousingPensionViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: myHousingPensionViewController,
            withNextStepper: myHousingPensionViewController.viewModel
        ))
    }
}
