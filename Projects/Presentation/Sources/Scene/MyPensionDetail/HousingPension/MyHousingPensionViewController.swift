import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class MyHousingPensionViewController: BaseViewController<MyHousingPensionViewModel> {

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
        $0.image = .housingPension
        $0.layer.cornerRadius = 32
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .gray50
    }

    private let pensionTypeLabel = UILabel().then {
        $0.textColor = .yellow500
        $0.text = "주택연금"
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
    private let paymentMethodMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "결제방법"
        $0.font = .titleSmall
    }

    private let paymentMethodLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "카드"
        $0.font = .titleMedium
    }

    private let pensionEndDateMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "연금수령 종료일"
        $0.font = .titleSmall
    }

    private let pensionEndDateLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "2024.01.01"
        $0.font = .titleMedium
    }

    private let moneyBackgroundView = UIView().then {
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 6
    }
    private let moneySeparateView = UIView().then {
        $0.backgroundColor = .gray100
        $0.layer.cornerRadius = 1
    }

    private let managementPointMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "관리지점"
        $0.font = .titleSmall
    }

    private let managementPointLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "동사무소"
        $0.font = .titleMedium
    }

    private let expectedPensionAmountMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "예상 연금액"
        $0.font = .titleSmall
    }

    private let expectedPensionAmountLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "4,000,000원"
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
            
            paymentMethodMarkLabel,
            paymentMethodLabel,
            pensionEndDateMarkLabel,
            pensionEndDateLabel,

            moneyBackgroundView
        ].forEach { contentView.addSubview($0) }

        [
            moneySeparateView,
            managementPointMarkLabel,
            managementPointLabel,
            expectedPensionAmountMarkLabel,
            expectedPensionAmountLabel
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


        paymentMethodMarkLabel.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        paymentMethodLabel.snp.makeConstraints {
            $0.top.equalTo(paymentMethodMarkLabel.snp.bottom).offset(8)
            $0.leading.equalTo(paymentMethodMarkLabel)
        }
        pensionEndDateMarkLabel.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom).offset(32)
            $0.leading.equalTo(paymentMethodMarkLabel.snp.trailing).offset(58)
        }
        pensionEndDateLabel.snp.makeConstraints {
            $0.top.equalTo(pensionEndDateMarkLabel.snp.bottom).offset(8)
            $0.leading.equalTo(pensionEndDateMarkLabel)
        }

        moneyBackgroundView.snp.makeConstraints {
            $0.top.equalTo(paymentMethodLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(expectedPensionAmountLabel).offset(24)
        }
        managementPointMarkLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        managementPointLabel.snp.makeConstraints {
            $0.top.equalTo(managementPointMarkLabel.snp.bottom).offset(4)
            $0.leading.equalTo(managementPointMarkLabel)
            $0.height.equalTo(32)
        }
        moneySeparateView.snp.makeConstraints {
            $0.top.equalTo(managementPointLabel.snp.bottom).offset(12)
            $0.height.equalTo(2)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        expectedPensionAmountMarkLabel.snp.makeConstraints {
            $0.top.equalTo(moneySeparateView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        expectedPensionAmountLabel.snp.makeConstraints {
            $0.top.equalTo(expectedPensionAmountMarkLabel.snp.bottom).offset(4)
            $0.leading.equalTo(expectedPensionAmountMarkLabel)
            $0.height.equalTo(32)
        }
    }
}
