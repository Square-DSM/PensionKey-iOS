import UIKit
import RxFlow
import Core
import Presentation
import PensionKeyKit

public class TabsFlow: Flow {
    
    public var root: Presentable {
        return rootViewController
    }
    
    private let rootViewController = UITabBarController().then {
        $0.tabBar.tintColor = .yellow800
        $0.tabBar.unselectedItemTintColor = .gray400
        $0.tabBar.backgroundColor = .white
        $0.tabBar.layer.cornerRadius = 12
        let shadowView = UIView().then {
            $0.layer.shadowRadius = 12
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = .init(width: 0, height: 2)
            $0.layer.shadowOpacity = 0.2
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        $0.tabBar.addSubview(shadowView)
        shadowView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }

    public func navigate(to step: RxFlow.Step) -> FlowContributors {
        guard let step = step as? PensionStep else { return .none }
        
        switch step {
        case .tabsRequire:
            return navigateToTabsScreen()
        default:
            return .none
        }
    }

    private func navigateToTabsScreen() -> FlowContributors {
        let myPensionFlow = MyPensionFlow()
        let noticeFlow = NoticeFlow()
        let benefitFlow = BenefitFlow()
        let myPageFlow = MyPageFlow()

        Flows.use(
            myPensionFlow,
            noticeFlow,
            benefitFlow,
            myPageFlow,
            when: .created
        ) { [weak self] root1, root2, root3, root4 in
            let tabBarItem1 = UITabBarItem(
                title: "내 연금",
                image: .coin.withTintColor(.gray400, renderingMode: .alwaysOriginal),
                selectedImage: .coin
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
            }
            let tabBarItem2 = UITabBarItem(
                title: "게시판",
                image: .bulletinBoard.withTintColor(.gray400, renderingMode: .alwaysOriginal),
                selectedImage: .bulletinBoard
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
            }
            let tabBarItem3 = UITabBarItem(
                title: "혜택",
                image: .gift.withTintColor(.gray400, renderingMode: .alwaysOriginal),
                selectedImage: .gift
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
            }
            let tabBarItem4 = UITabBarItem(
                title: "마이",
                image: .account.withTintColor(.gray400, renderingMode: .alwaysOriginal),
                selectedImage: .account
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .medium)], for: .normal)
            }
            root1.tabBarItem = tabBarItem1
            root2.tabBarItem = tabBarItem2
            root3.tabBarItem = tabBarItem3
            root4.tabBarItem = tabBarItem4
            self?.rootViewController.setViewControllers([root1, root2, root3, root4], animated: false)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: myPensionFlow,
                        withNextStepper: OneStepper(withSingleStep: PensionStep.myPensionRequire))
        ])
    }
}
