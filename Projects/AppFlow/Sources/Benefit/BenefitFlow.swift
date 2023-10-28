import UIKit
import RxFlow
import Core
import Presentation

public class BenefitFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = BaseNavigationController()

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .benefitRequire:
            return presentBenefitView()
        default:
            return .none
        }
    }

    private func presentBenefitView() -> FlowContributors {
        let benefitViewController = BenefitViewController(BenefitViewModel())
        rootViewController.pushViewController(benefitViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: benefitViewController,
            withNextStepper: benefitViewController.viewModel
        ))
    }
}
