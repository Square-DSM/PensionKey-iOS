import UIKit
import RxFlow
import Core
import Presentation

public class NoticeDetailFlow: Flow {

    public var root: Presentable {
        return presentalbeView
    }

    let presentalbeView: NoticeDetailViewController
    public init() {
        self.presentalbeView = NoticeDetailViewController(container.noticeDetailViewModel)
    }
    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .noticeDetailRequire(let id):
            return presentNoticeDetailView(id: id)
        case .noticeRequire:
            return presentNoticeView()
        default:
            return .none
        }
    }

    private func presentNoticeView() -> FlowContributors {
        self.presentalbeView.navigationController?.popViewController(animated: true)
        return .none
    }

    private func presentNoticeDetailView(id: String) -> FlowContributors {
        presentalbeView.id = id
        return .one(flowContributor: .contribute(
            withNextPresentable: presentalbeView,
            withNextStepper: presentalbeView.viewModel
        ))
    }
}
