import UIKit
import RxFlow
import Core

public class AppFlow: Flow {

    public var root: Presentable {
        return window
    }

    let window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .loginRequire:
            return presentLoginView()
        case .tabsRequire:
            return presentTabsView()
        default:
            return .none
        }
    }

    private func presentLoginView() -> FlowContributors {
        let loginFlow = LoginFlow()
        Flows.use(loginFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }

        return .one(
            flowContributor: .contribute(
                withNextPresentable: loginFlow,
                withNextStepper: OneStepper(withSingleStep: PensionStep.loginRequire)
            )
        )
    }

    private func presentTabsView() -> FlowContributors {
        let tabsFlow = TabsFlow()
        Flows.use(tabsFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }

        return .one(
            flowContributor: .contribute(
                withNextPresentable: tabsFlow,
                withNextStepper: OneStepper(withSingleStep: PensionStep.tabsRequire)
            )
        )
    }
}
