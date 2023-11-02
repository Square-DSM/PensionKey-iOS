import UIKit
import RxFlow
import Core
import Presentation

public class SearchFlow: Flow {

    public var root: Presentable {
        return presentalbeView
    }

    let presentalbeView: SearchViewController
    public init() {
        self.presentalbeView = SearchViewController(container.searchViewModel)
    }
    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .searchRequire:
            return presentSearchView()
        case .noticeDetailRequire(let id):
            return presentNoticeDetailView(id: id)
        default:
            return .none
        }
    }

    private func presentNoticeDetailView(id: String) -> FlowContributors {
        let noticeDetailFlow = NoticeDetailFlow()
        Flows.use(noticeDetailFlow, when: .created) { root in
            self.presentalbeView.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: noticeDetailFlow,
            withNextStepper: OneStepper(withSingleStep: PensionStep.noticeDetailRequire(id: id))
        ))
    }

    private func presentSearchView() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: presentalbeView,
            withNextStepper: presentalbeView.viewModel
        ))
    }
}
