import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class MyPensionDetailViewController: BaseViewController<MyPensionDetailViewModel> {

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }

    private let contentView = UIView().then {
        $0.backgroundColor = .blue
    }

    private let separateView = UIView().then {
        $0.backgroundColor = .gray50
    }

    private let pensionImageView = UIImageView().then {
        $0.layer.cornerRadius = 32
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .gray50
    }

    private let pensionTypeLabel = UILabel().then {
        $0.textColor = .yellow500
        $0.text = "국민연금"
        $0.font = .titleLarge
    }

    private let pensionPriceLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "100,000원"
        $0.font = .titleLarge
    }

    private let ablePensionLabel = UIPaddingLabel(padding: UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)).then {
        $0.textColor = .black
        $0.text = "받을 수 있는 연금"
        $0.font = .labelSmall
        $0.backgroundColor = .yellow100
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            separateView,
            pensionImageView,
            pensionTypeLabel,
            pensionPriceLabel,
            ablePensionLabel
        ].forEach { contentView.addSubview($0) }
    }

    public override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
        pensionImageView.snp.makeConstraints {
            $0.width.height.equalTo(64)
            $0.left.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(32)
        }
        pensionTypeLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(pensionImageView.snp.bottom).offset(23)
        }
        pensionPriceLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(pensionTypeLabel.snp.bottom).offset(2)
        }
        ablePensionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(pensionPriceLabel.snp.bottom).offset(23)
        }
        separateView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(8)
            $0.top.equalTo(ablePensionLabel.snp.bottom).offset(42)
        }
    }
}
