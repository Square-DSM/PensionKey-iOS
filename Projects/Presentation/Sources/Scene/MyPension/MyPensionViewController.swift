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
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .gray500
        $0.text = "연금열쇠"
    }
    private let nameLabel = UIPaddingLabel(padding: .init(top: 2, left: 8, bottom: 2, right: 8)).then {
        $0.text = "박주영"
        $0.backgroundColor = .yellow100
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .yellow900
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let nameInfoLabel = UILabel().then {
        $0.text = "님은 연금으로 총"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    private let totalMoneyLabel = UILabel().then {
        $0.text = "320,000원"
        $0.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        $0.textColor = .black
    }
    private let moneyInfoLabel = UILabel().then {
        $0.text = "을 받고 있어요"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
    }
    private lazy var pensionColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MyPensionCollectionViewCell.self, forCellWithReuseIdentifier: MyPensionCollectionViewCell.identifier)
        return collectionView
    }()

    public override func attribute() {
        self.navigationController?.isNavigationBarHidden = true
        pensionColletionView.dataSource = self
        pensionColletionView.delegate = self
    }

    public override func bind() {
        let input = MyPensionViewModel.Input(
            isSelectedCollectionViewCell: pensionColletionView.rx.itemSelected.asControlEvent()
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
            pensionColletionView
        ].forEach { self.view.addSubview($0) }
    }
    public override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(61)
            $0.leading.equalToSuperview().inset(18)
            $0.width.height.equalTo(32)
        }
        logoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(66)
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
        pensionColletionView.snp.makeConstraints {
            $0.top.equalTo(moneyInfoLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottomMargin.equalToSuperview().offset(-20)
        }
    }
}

extension MyPensionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyPensionCollectionViewCell.identifier,
            for: indexPath
        ) as? MyPensionCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 110)
    }
}
