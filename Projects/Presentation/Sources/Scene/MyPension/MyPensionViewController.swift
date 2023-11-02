import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class MyPensionViewController: BaseViewController<MyPensionViewModel> {

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
        $0.text = "600,000원"
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MyNationalPensionCollectionViewCell.self, forCellWithReuseIdentifier: MyNationalPensionCollectionViewCell.identifier)
        return collectionView
    }()

    private lazy var personalPensionColletionView: UICollectionView = { // 개인
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MyPersonalPensionColletionCell.self, forCellWithReuseIdentifier: MyPersonalPensionColletionCell.identifier)
        return collectionView
    }()

    private lazy var housingPensionColletionView: UICollectionView = { // 주택
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MyHousingPensionColletionCell.self, forCellWithReuseIdentifier: MyHousingPensionColletionCell.identifier)
        return collectionView
    }()

    public override func attribute() {
        nationalPensionColletionView.delegate = self
        nationalPensionColletionView.dataSource = self
        personalPensionColletionView.delegate = self
        personalPensionColletionView.dataSource = self
        housingPensionColletionView.delegate = self
        housingPensionColletionView.dataSource = self
    }

    public override func bind() {
        let input = MyPensionViewModel.Input(
            isSelectedNationalCell: nationalPensionColletionView.rx.itemSelected,
            isSelectedPersonalCell: personalPensionColletionView.rx.itemSelected,
            isSelectedHousingCell: housingPensionColletionView.rx.itemSelected
        )

        
        _ = viewModel.transform(input)
    }

    public override func addView() {
        [
            logoImageView,
            logoLabel,
            nameLabel,
            nameInfoLabel,
            totalMoneyLabel,
            moneyInfoLabel,
            nationalPensionColletionView,
            personalPensionColletionView,
            housingPensionColletionView
        ].forEach { self.view.addSubview($0) }
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
        nationalPensionColletionView.snp.makeConstraints {
            $0.top.equalTo(moneyInfoLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(130)
        }
        personalPensionColletionView.snp.makeConstraints {
            $0.top.equalTo(nationalPensionColletionView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        housingPensionColletionView.snp.makeConstraints {
            $0.top.equalTo(personalPensionColletionView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(130)
        }
    }
}

extension MyPensionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == nationalPensionColletionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyNationalPensionCollectionViewCell.identifier,
                for: indexPath
            ) as? MyNationalPensionCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        else if collectionView == personalPensionColletionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyPersonalPensionColletionCell.identifier,
                for: indexPath
            ) as? MyPersonalPensionColletionCell else { return UICollectionViewCell() }
            return cell
        }
        else if collectionView == housingPensionColletionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyHousingPensionColletionCell.identifier,
                for: indexPath
            ) as? MyHousingPensionColletionCell else { return UICollectionViewCell() }
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == personalPensionColletionView {
            return CGSize(width: collectionView.frame.width, height: 146)
        } else {
            return CGSize(width: collectionView.frame.width, height: 128)
        }
    }
}
