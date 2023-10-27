import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class BenefitViewController: UIViewController, Stepper {
    public let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
