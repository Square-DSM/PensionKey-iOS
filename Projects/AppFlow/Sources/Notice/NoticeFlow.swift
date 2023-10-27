import UIKit
import RxFlow
import Core
import Presentation

public class NoticeFlow: Flow {

    public var root: Presentable {
        return rootViewController
    }

    let rootViewController = UINavigationController()

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }

        switch step {
        case .noticeRequire:
            return presentNoticeView()
        default:
            return .none
        }
    }

    private func presentNoticeView() -> FlowContributors {
        let noticeViewController = NoticeViewController()
        rootViewController.pushViewController(noticeViewController, animated: false)
        return .one(flowContributor: .contribute(withNext: noticeViewController)
        )
    }
}
