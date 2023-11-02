import UIKit
import SnapKit
import Then
import PensionKeyKit

class CommentTableViewCell: UITableViewCell {
    static let identifier = "NoticeTableViewCell"
    let commentImageView = UIImageView().then {
        $0.image = .logoDark
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    let commentLabel = UILabel().then {
        $0.text = "그렇다고요.."
        $0.font = .bodyMedium
        $0.textColor = .black
    }
    let idAndDateLabel = UILabel().then {
        $0.text = "park1 · 1분 전"
        $0.font = .bodySmall
        $0.textColor = .gray500
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView() {
        [
            commentImageView,
            commentLabel,
            idAndDateLabel
        ].forEach { self.addSubview($0) }
    }
    private func setLayout() {
        commentImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        commentLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.centerY)
            $0.leading.equalTo(commentImageView.snp.trailing).offset(12)
        }
        idAndDateLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY)
            $0.leading.equalTo(commentImageView.snp.trailing).offset(12)
        }
    }
}
