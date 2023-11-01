import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class MyPersonalPensionViewController: BaseViewController<MyPersonalPensionViewModel> {

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
        $0.image = .personalPension
        $0.layer.cornerRadius = 32
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .gray50
    }

    private let pensionTypeLabel = UILabel().then {
        $0.textColor = .yellow500
        $0.text = "개인연금"
        $0.font = .titleLarge
    }

    private let pensionPriceLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "100,000원"
        $0.font = .titleLarge
    }

    private let ablePensionLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "을 받을 수 있어요"
        $0.font = .bodyMedium
    }

    // MARK: 추가
    private let perPentionMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "삼성 생명 다이렉트"
        $0.font = .titleSmall
    }

    private let perPentionLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "삼성 인터넷 NEW 연금보험"
        $0.font = .titleMedium
    }

    private let moneyBackgroundView = UIView().then {
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 6
    }

    private let totalMonryMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "총 납입 금액"
        $0.font = .titleSmall
    }

    private let totalMonryLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "2,000,000원"
        $0.font = .titleMedium
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
            ablePensionLabel,
            
            perPentionMarkLabel,
            perPentionLabel,

            moneyBackgroundView
        ].forEach { contentView.addSubview($0) }

        [
            totalMonryMarkLabel,
            totalMonryLabel
        ].forEach { moneyBackgroundView.addSubview($0) }
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


        perPentionMarkLabel.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        perPentionLabel.snp.makeConstraints {
            $0.top.equalTo(perPentionMarkLabel.snp.bottom).offset(8)
            $0.leading.equalTo(perPentionMarkLabel)
        }

        moneyBackgroundView.snp.makeConstraints {
            $0.top.equalTo(perPentionLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(totalMonryLabel).offset(24)
        }
        totalMonryMarkLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        totalMonryLabel.snp.makeConstraints {
            $0.top.equalTo(totalMonryMarkLabel.snp.bottom).offset(4)
            $0.leading.equalTo(totalMonryMarkLabel)
            $0.height.equalTo(32)
        }
    }
}
