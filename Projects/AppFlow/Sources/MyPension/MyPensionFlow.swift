import UIKit
import RxFlow
import Core
import Presentation

public class MyPensionFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = BaseNavigationController()

    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .myPensionRequire:
            return presentMyPensionView()
        case .myNationalPensionDetailRequire:
            return presentMyNationalPensionDetailRequire()
        case .myPersonalPensionDetailRequire(let id):
            return presentMyPersonalPensionDetailRequire(id: id)
        case .myHousingPensionDetailRequire(let id):
            return presentMyHousingPensionDetailRequire(id: id)
        default:
            return .none
        }
    }

    private func presentMyPensionView() -> FlowContributors {
        let myPensionViewController = MyPensionViewController(container.myPensionViewModel)
        rootViewController.pushViewController(myPensionViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: myPensionViewController,
            withNextStepper: myPensionViewController.viewModel
        ))
    }

    private func presentMyNationalPensionDetailRequire() -> FlowContributors {
        let myNationalPensionDetailViewController = MyNationalPensionDetailViewController(container.myNationalPensionDetailViewModel)
        rootViewController.pushViewController(myNationalPensionDetailViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: myNationalPensionDetailViewController,
            withNextStepper: myNationalPensionDetailViewController.viewModel
        ))
    }

    private func presentMyPersonalPensionDetailRequire(id: String) -> FlowContributors {
        let myPersonalPensionViewController = MyPersonalPensionViewController(container.myPersonalPensionViewModel)
        myPersonalPensionViewController.id = id
        rootViewController.pushViewController(myPersonalPensionViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: myPersonalPensionViewController,
            withNextStepper: myPersonalPensionViewController.viewModel
        ))
    }

    private func presentMyHousingPensionDetailRequire(id: String) -> FlowContributors {
        let myHousingPensionViewController = MyHousingPensionViewController(container.myHousingPensionViewModel)
        myHousingPensionViewController.id = id
        rootViewController.pushViewController(myHousingPensionViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: myHousingPensionViewController,
            withNextStepper: myHousingPensionViewController.viewModel
        ))
    }
}
