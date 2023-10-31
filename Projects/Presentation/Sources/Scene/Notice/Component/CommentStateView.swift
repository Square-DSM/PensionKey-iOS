import UIKit
import Then
import SnapKit

public class CommentStateView: UILabel {
    private let commentImageView = UIImageView().then {
        $0.image = .chat
    }
    public let commentStateLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .gray400
        $0.font = .bodySmall
    }
    public override func layoutSubviews() {
        [
            commentImageView,
            commentStateLabel
        ].forEach { addSubview($0) }

        commentImageView.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.top.bottom.equalToSuperview().inset(1)
            $0.leading.equalToSuperview()
        }
        commentStateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(commentImageView.snp.trailing).offset(4)
        }
    }
}
