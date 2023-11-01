import RxFlow
import UIKit
extension Flow {
    public func presentError(view: UIViewController) -> FlowContributors {
        let alertController = UIAlertController.init(title: "오류", message: "오류가 발생하였습니다. 다시 시도해주세요", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .cancel)
        alertController.addAction(alertAction)
        view.present(alertController, animated: true)
        return .none
    }
}
