import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class MyNationalPensionDetailViewController: BaseViewController<MyNationalPensionDetailViewModel> {

    private let viewDidLoadRelay = PublishRelay<Void>()

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
        $0.image = .nationalPension
        $0.layer.cornerRadius = 32
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .gray50
    }

    private let pensionTypeLabel = UILabel().then {
        $0.textColor = .yellow500
        $0.text = "국민연금"
        $0.font = .titleLarge
    }

    private let pensionPriceLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "300,000원"
        $0.font = .titleLarge
    }

    private let ablePensionLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "을 받을 수 있어요"
        $0.font = .bodyMedium
    }

    // MARK: 추가
    private let monthOfinsuranceMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "납부한 보험료 월수"
        $0.font = .titleSmall
    }

    private let monthOfinsuranceLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "2개월"
        $0.font = .titleMedium
    }

    private let sinceOfinsuranceMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "수급개시 년월"
        $0.font = .titleSmall
    }

    private let sinceOfinsuranceLabel = UILabel().then {
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

    private let averageIncomeMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "평균 소득 월액"
        $0.font = .titleSmall
    }

    private let averageIncomeLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "2,000,000원"
        $0.font = .titleMedium
    }

    private let expectationIncomeMarkLabel = UILabel().then {
        $0.textColor = .gray700
        $0.text = "예상 남부 보험료 총액"
        $0.font = .titleSmall
    }

    private let expectationIncomeLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "4,000,000원"
        $0.font = .titleMedium
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadRelay.accept(())
    }

    public override func bind() {
        let input = MyNationalPensionDetailViewModel.Input(viewDidLoad: viewDidLoadRelay.asObservable())
        let output = viewModel.transform(input)

        output.detailData.asObservable()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
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
            
            monthOfinsuranceMarkLabel,
            monthOfinsuranceLabel,
            sinceOfinsuranceMarkLabel,
            sinceOfinsuranceLabel,

            moneyBackgroundView
        ].forEach { contentView.addSubview($0) }

        [
            moneySeparateView,
            averageIncomeMarkLabel,
            averageIncomeLabel,
            expectationIncomeMarkLabel,
            expectationIncomeLabel
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


        monthOfinsuranceMarkLabel.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        monthOfinsuranceLabel.snp.makeConstraints {
            $0.top.equalTo(monthOfinsuranceMarkLabel.snp.bottom).offset(8)
            $0.leading.equalTo(monthOfinsuranceMarkLabel)
        }
        sinceOfinsuranceMarkLabel.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom).offset(32)
            $0.leading.equalTo(monthOfinsuranceMarkLabel.snp.trailing).offset(58)
        }
        sinceOfinsuranceLabel.snp.makeConstraints {
            $0.top.equalTo(sinceOfinsuranceMarkLabel.snp.bottom).offset(8)
            $0.leading.equalTo(sinceOfinsuranceMarkLabel)
        }

        moneyBackgroundView.snp.makeConstraints {
            $0.top.equalTo(monthOfinsuranceLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(expectationIncomeLabel).offset(24)
        }
        averageIncomeMarkLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        averageIncomeLabel.snp.makeConstraints {
            $0.top.equalTo(averageIncomeMarkLabel.snp.bottom).offset(4)
            $0.leading.equalTo(averageIncomeMarkLabel)
            $0.height.equalTo(32)
        }
        moneySeparateView.snp.makeConstraints {
            $0.top.equalTo(averageIncomeLabel.snp.bottom).offset(12)
            $0.height.equalTo(2)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        expectationIncomeMarkLabel.snp.makeConstraints {
            $0.top.equalTo(moneySeparateView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        expectationIncomeLabel.snp.makeConstraints {
            $0.top.equalTo(expectationIncomeMarkLabel.snp.bottom).offset(4)
            $0.leading.equalTo(expectationIncomeMarkLabel)
            $0.height.equalTo(32)
        }
    }
}
