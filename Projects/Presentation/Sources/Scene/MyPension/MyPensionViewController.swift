import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class MyPensionViewController: BaseViewController<MyPensionViewModel> {

    private let housingPensionId = PublishRelay<String>()
    private let PersonalPensionId = PublishRelay<String>()

    private let viewDidLoadRelay = PublishRelay<Void>()
    private var totalPension: Int = 0 {
        didSet {
            self.totalMoneyLabel.text = "\(totalPension.toDecimal())원"
        }
    }

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.bounces = false
    }
    private let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    private let logoImageView = UIImageView().then {
        $0.image = .logo
    }
    private let logoLabel = UILabel().then {
        $0.font = PensionKeyKitFontFamily.Pretendard.extraBold.font(size: 16)
        $0.textColor = .gray500
        $0.text = "연금열쇠"
    }
    private let nameLabel = UIPaddingLabel(padding: .init(top: 2, left: 8, bottom: 2, right: 8)).then {
        $0.text = "박주영"
        $0.backgroundColor = .yellow100
        $0.font = .labelSmall
        $0.textColor = .yellow900
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let nameInfoLabel = UILabel().then {
        $0.text = "님은 연금으로 총"
        $0.textColor = .black
        $0.font = .bodySmall
    }
    private let totalMoneyLabel = UILabel().then {
        $0.text = "-원"
        $0.font = .titleLarge
        $0.textColor = .black
    }
    private let moneyInfoLabel = UILabel().then {
        $0.text = "을 받고 있어요"
        $0.font = .bodyMedium
        $0.textColor = .black
    }
    
    private lazy var nationalPensionColletionView: UICollectionView = { // 국민
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 128)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(MyNationalPensionCollectionViewCell.self, forCellWithReuseIdentifier: MyNationalPensionCollectionViewCell.identifier)
        return collectionView
    }()

    private lazy var personalPensionColletionView: UICollectionView = { // 개인
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 146)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(MyPersonalPensionColletionCell.self, forCellWithReuseIdentifier: MyPersonalPensionColletionCell.identifier)
        return collectionView
    }()

    private lazy var housingPensionColletionView: UICollectionView = { // 주택
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 128)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(MyHousingPensionColletionCell.self, forCellWithReuseIdentifier: MyHousingPensionColletionCell.identifier)
        return collectionView
    }()

    public override func viewWillAppear(_ animated: Bool) {
        viewDidLoadRelay.accept(())
        totalPension = 0
    }

    public override func attribute() {
        
    }

    public override func bind() {
        let input = MyPensionViewModel.Input(
            isSelectedNationalCell: nationalPensionColletionView.rx.itemSelected,
            isSelectedPersonalCell: PersonalPensionId.asObservable(),
            isSelectedHousingCell: housingPensionId.asObservable(),
            viewDidLoad: viewDidLoadRelay.asObservable()
        )
        let output = viewModel.transform(input)

        personalPensionColletionView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.personalPensionColletionView.cellForItem(at: index) as? MyPersonalPensionColletionCell else { return "" }
                return cell.id
            }
            .bind(to: PersonalPensionId)
            .disposed(by: disposeBag)
    
        housingPensionColletionView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.housingPensionColletionView.cellForItem(at: index) as? MyHousingPensionColletionCell else { return "" }
                return cell.id
            }
            .bind(to: housingPensionId)
            .disposed(by: disposeBag)

        output.nationalData.asObservable()
            .bind(to: nationalPensionColletionView.rx.items(
                cellIdentifier: MyNationalPensionCollectionViewCell.identifier,
                cellType: MyNationalPensionCollectionViewCell.self
            )) { (row, element, cell) in
                cell.contentLabel.text = "\(element.payMonth)개월 동안 납부했어요"
                cell.pensionLabel.text = "\(element.expectTotalPay.toDecimal())원"
                self.totalPension += element.expectTotalPay
            }
            .disposed(by: disposeBag)
        
        output.personalData.asObservable()
            .bind(to: personalPensionColletionView.rx.items(
                cellIdentifier: MyPersonalPensionColletionCell.identifier,
                cellType: MyPersonalPensionColletionCell.self
            )) { (row, element, cell) in
                cell.id = element.id
                cell.contentLabel.text = "\(element.companyName) •\n\(element.productName)"
                cell.pensionLabel.text = "\(element.totalPaymentAmt.toDecimal())원"
                self.totalPension += element.totalPaymentAmt
            }
            .disposed(by: disposeBag)

        output.housingData.asObservable()
            .bind(to: housingPensionColletionView.rx.items(
                cellIdentifier: MyHousingPensionColletionCell.identifier,
                cellType: MyHousingPensionColletionCell.self
            )) { (row, element, cell) in
                cell.id = element.id
                cell.contentLabel.text = "\(element.pensionEndDate) 까지 • \(element.paymentType)결제"
                cell.pensionLabel.text = "\(element.expectPension.toDecimal())원"
                self.totalPension += element.expectPension
            }
            .disposed(by: disposeBag)

        output.userData.asObservable()
            .bind(onNext: { [self] in
                nameLabel.text =  $0.name
            }).disposed(by: disposeBag)
    }

    public override func addView() {
        [
            logoImageView,
            logoLabel,
            nameLabel,
            nameInfoLabel,
            totalMoneyLabel,
            moneyInfoLabel,
            scrollView
        ].forEach { self.view.addSubview($0) }
        scrollView.addSubview(contentView)
        [
            nationalPensionColletionView,
            personalPensionColletionView,
            housingPensionColletionView
        ].forEach { contentView.addSubview($0) }
    }

    public override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(61)
            $0.leading.equalToSuperview().inset(18)
            $0.width.height.equalTo(32)
        }
        logoLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView.snp.centerY)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(4)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.equalTo(logoImageView.snp.bottom).offset(40)
        }
        nameInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8)
            $0.top.equalTo(logoImageView.snp.bottom).offset(40)
        }
        totalMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        moneyInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(totalMoneyLabel.snp.bottom).offset(8)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(moneyInfoLabel.snp.bottom).offset(32)
            $0.width.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(housingPensionColletionView.snp.bottom).offset(20)
        }
        nationalPensionColletionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(128)
        }
        personalPensionColletionView.snp.makeConstraints {
            $0.top.equalTo(nationalPensionColletionView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150 * 3)
        }
        housingPensionColletionView.snp.makeConstraints {
            $0.top.equalTo(personalPensionColletionView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(128)
        }
    }
}
