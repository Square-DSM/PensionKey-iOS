import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import Domain
import PensionKeyKit

public class CommentView: UIView {
    private let disposeBag = DisposeBag()
    private let commentTitleLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = .titleSmall
        $0.textColor = .black
    }
    let countLabel = UILabel().then {
        $0.text = "0"
        $0.font = .titleSmall
        $0.textColor = .yellow500
    }
    let commentTextField = UITextField().then {
        $0.addLeftPadding(size: 12)
        $0.addRightPadding(size: 12)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.layer.cornerRadius = 6
        $0.placeholder = "댓글을 작성해보세요."
        $0.font = .bodyMedium
    }
    let registerButton = UIButton(type: .system).then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.yellow700, for: .normal)
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 6
    }
    public let commentTableView = UITableView().then {
        $0.rowHeight = 56
        $0.isScrollEnabled = false
        $0.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
    }
    public override func layoutSubviews() {
        [
            commentTitleLabel,
            countLabel,
            commentTextField,
            registerButton,
            commentTableView
        ].forEach { self.addSubview($0) }
        commentTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(commentTitleLabel.snp.trailing).offset(8)
        }
        commentTextField.snp.makeConstraints {
            $0.top.equalTo(commentTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(registerButton.snp.leading).offset(-8)
            $0.height.equalTo(38)
        }
        registerButton.snp.makeConstraints {
            $0.top.equalTo(commentTitleLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(64)
            $0.height.equalTo(38)
        }
        UIView.animate(withDuration: 0.5) { [self] in
            commentTableView.snp.updateConstraints {
                $0.top.equalTo(commentTextField.snp.bottom).offset(20)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.greaterThanOrEqualTo(commentTableView.numberOfRows(inSection: 0) * 56)
            }
        }
        self.snp.makeConstraints {
            $0.top.equalTo(commentTitleLabel.snp.top)
            $0.bottom.equalTo(commentTableView.snp.bottom)
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
