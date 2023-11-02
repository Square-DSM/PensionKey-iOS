import UIKit
import SnapKit
import Then
import PensionKeyKit

class NoticeTableViewCell: UITableViewCell {
    static let identifier = "NoticeTableViewCell"
    var id = ""
    let titleLabel = UILabel().then {
        $0.text = "기초생활 수급자도 국민연금에 가입할 수 있나요?"
        $0.font = .bodyLarge
        $0.numberOfLines = 100
    }
    let idAndDateLabel = UILabel().then {
        $0.text = "park01 · 1시간 전"
        $0.font = .bodySmall
        $0.textColor = .gray500
    }
    let commentStateView = CommentStateView().then {
        $0.commentStateLabel.text = "3"
    }
    func setUp() {
        addView()
        setLayout()
    }
    private func addView() {
        [
            titleLabel,
            idAndDateLabel,
            commentStateView
        ].forEach { self.addSubview($0) }
    }
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
        }
        idAndDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        commentStateView.snp.makeConstraints {
            $0.top.equalTo(idAndDateLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
            $0.height.equalTo(18)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
