import UIKit
import RxFlow
import Core
import Presentation

public class WriteNoticeFlow: Flow {

    public var root: Presentable {
        return presentalbeView
    }

    let presentalbeView: WriteNoticeViewController
    public init() {
        self.presentalbeView = WriteNoticeViewController(container.writeNoticeViewModel)
    }
    private let container = StepperDI.shared

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .writeNoticeRequire:
            return presentwriteNoticeView()
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

    private func presentwriteNoticeView() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: presentalbeView,
            withNextStepper: presentalbeView.viewModel
        ))
    }
}
