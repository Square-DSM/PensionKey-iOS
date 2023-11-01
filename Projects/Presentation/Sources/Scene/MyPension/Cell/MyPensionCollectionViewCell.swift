import UIKit
import SnapKit
import Then
import PensionKeyKit

class MyPensionCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyPensionTableViewCell"

    let pensionImageView = UIImageView().then {
        $0.layer.cornerRadius = 100
        $0.image = .nationalPension
    }
    let pensionTypeLabel = UILabel().then {
        $0.font = .bodySmall
        $0.textColor = .black
        $0.text = "국민연금"
    }
    let pensionLabel = UILabel().then {
        $0.font = .titleMedium
        $0.textColor = .black
        $0.text = "300,000원"
    }
    let contentLabel = UILabel().then {
        $0.font = .bodySmall
        $0.textColor = .gray600
        $0.numberOfLines = 0
        $0.text = "2개월 동안 납부했어요."
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
            pensionLabel,
            contentLabel
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
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(pensionLabel.snp.bottom).offset(4)
            $0.leading.equalTo(pensionLabel)
            $0.trailing.equalToSuperview().inset(40)
        }
    }
}
