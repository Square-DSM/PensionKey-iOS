import UIKit
import Then
import SnapKit
import PensionKeyKit

public class ProfileView: UIView {
    public let profileImageView = UIImageView().then {
        $0.image = .chat
    }
    public let idLabel = UILabel().then {
        $0.text = "park01"
        $0.textColor = .black
        $0.font = .bodySmall
    }
    public let dateLabel = UILabel().then {
        $0.text = "1시간 전"
        $0.textColor = .gray500
        $0.font = .bodySmall
    }
    public let moreButton = UIButton(type: .system).then {
        $0.setImage(.init(cgImage: (UIImage(systemName: "ellipsis")?.cgImage)!, scale: 2, orientation: .right), for: .normal)
        $0.tintColor = .black
    }
    public override func layoutSubviews() {
        [
            profileImageView,
            idLabel,
            dateLabel,
            moreButton
        ].forEach { self.addSubview($0) }
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        idLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.bottom.equalTo(self.snp.centerY).offset(-1)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.top.equalTo(self.snp.centerY).offset(1)
        }
        moreButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview()
        }
    }
}
