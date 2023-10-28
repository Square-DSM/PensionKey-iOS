import UIKit
import SnapKit
import Then
import PensionKeyKit

class MyPensionCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyPensionTableViewCell"
    let pensionImageView = UIImageView().then {
        $0.layer.cornerRadius = 100
        $0.backgroundColor = .red
        $0.image = .checkmark
    }
    let pensionTypeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .black
        $0.text = "국민연금"
    }
    let pensionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.text = "300,000원"
    }
    override func layoutSubviews() {
        self.backgroundColor = .gray50
        self.layer.cornerRadius = 12
        addView()
        setLayout()
    }
    private func addView() {
        [
            pensionImageView,
            pensionTypeLabel,
            pensionLabel
        ].forEach { addSubview($0) }
    }
    private func setLayout() {
        pensionImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview().offset(-3)
            $0.width.height.equalTo(40)
        }
        pensionTypeLabel.snp.makeConstraints {
            $0.leading.equalTo(pensionImageView.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(32)
        }
        pensionLabel.snp.makeConstraints {
            $0.top.equalTo(pensionTypeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(pensionImageView.snp.trailing).offset(8)
        }
    }
}
