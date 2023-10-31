import UIKit
import RxFlow
import Core
import Presentation

public class NoticeFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = BaseNavigationController()

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .noticeRequire:
            return presentNoticeView()
        case .writeNoticeRequire:
            return presentWriteNoticeView()
        case .noticeDetailRequire:
            return presentNoticeDetailView()
        default:
            return .none
        }
    }

    private func presentNoticeView() -> FlowContributors {
        let noticeViewController = NoticeViewController(NoticeViewModel())
        rootViewController.pushViewController(noticeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: noticeViewController,
            withNextStepper: noticeViewController.viewModel
        ))
    }

    private func presentWriteNoticeView() -> FlowContributors {
        let writeNoticeViewController = WriteNoticeViewController(WriteNoticeViewModel())
        rootViewController.pushViewController(writeNoticeViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: writeNoticeViewController,
            withNextStepper: writeNoticeViewController.viewModel
        ))
    }

    private func presentNoticeDetailView() -> FlowContributors {
        let noticeDetailViewController = NoticeDetailViewController(NoticeDetailViewModel())
        rootViewController.pushViewController(noticeDetailViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: noticeDetailViewController,
            withNextStepper: noticeDetailViewController.viewModel
        ))
    }
}
