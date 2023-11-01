import UIKit
import RxFlow
import Core
import Presentation

public class NoticeFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = BaseNavigationController()
    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .noticeRequire:
            return presentNoticeView()
        case .writeNoticeRequire:
            return presentWriteNoticeView()
        case .noticeDetailRequire(let id):
            return presentNoticeDetailView(id: id)
        case .searchRequire:
            return presentSearchView()
        default:
            return .none
        }
    }

    private func presentNoticeView() -> FlowContributors {
        let noticeViewController = NoticeViewController(container.noticeViewModel)
        rootViewController.pushViewController(noticeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: noticeViewController,
            withNextStepper: noticeViewController.viewModel
        ))
    }

    private func presentWriteNoticeView() -> FlowContributors {
        let writeNoticeFlow = WriteNoticeFlow()
        Flows.use(writeNoticeFlow, when: .created) { root in
            self.rootViewController.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: writeNoticeFlow,
            withNextStepper: OneStepper(withSingleStep: PensionStep.writeNoticeRequire)
        ))
    }

    private func presentNoticeDetailView(id: String) -> FlowContributors {
        let noticeDetailViewController = NoticeDetailViewController(container.noticeDetailViewModel)
        rootViewController.pushViewController(noticeDetailViewController, animated: true)
        noticeDetailViewController.id = id
        return .one(flowContributor: .contribute(
            withNextPresentable: noticeDetailViewController,
            withNextStepper: noticeDetailViewController.viewModel
        ))
    }

    private func presentSearchView() -> FlowContributors {
        let searchViewController = SearchViewController(container.searchViewModel)
        rootViewController.pushViewController(searchViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: searchViewController,
            withNextStepper: searchViewController.viewModel
        ))
    }
}
