import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import Domain
import PensionKeyKit

public class CommentView: UIView {
    let commentList = BehaviorRelay<[CommentEntity]>(value: [])
    private let disposeBag = DisposeBag()
    private let titleLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = .titleSmall
        $0.textColor = .black
    }
    private let countLabel = UILabel().then {
        $0.text = "0"
        $0.font = .titleSmall
        $0.textColor = .yellow500
    }
    private let commentTextField = UITextField().then {
        $0.addLeftPadding(size: 12)
        $0.addRightPadding(size: 12)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray300.cgColor
        $0.layer.cornerRadius = 6
        $0.placeholder = "댓글을 작성해보세요."
        $0.font = .bodyMedium
    }
    private let registerButton = UIButton(type: .system).then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.yellow700, for: .normal)
        $0.backgroundColor = .yellow100
        $0.layer.cornerRadius = 6
    }
    public let commentTableView = UITableView().then {
        $0.rowHeight = 56
        $0.isScrollEnabled = false
        $0.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commentList.asObservable()
            .bind(to: commentTableView.rx.items(
                cellIdentifier: CommentTableViewCell.identifier,
                cellType: CommentTableViewCell.self
            )) { row, item, cell in
                cell.commentLabel.text = item.content
                cell.idAndDateLabel.text = "\(item.userAccountId) · "
            }.disposed(by: disposeBag)
    }
    public func setTableView(commentList: [CommentEntity]) {
        self.commentList.accept(commentList)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        [
            titleLabel,
            countLabel,
            commentTextField,
            registerButton,
            commentTableView
        ].forEach { self.addSubview($0) }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(20)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }
        commentTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(registerButton.snp.leading).offset(-8)
            $0.height.equalTo(38)
        }
        registerButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(64)
            $0.height.equalTo(38)
        }
        commentTableView.snp.makeConstraints {
            $0.top.equalTo(commentTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(commentTableView.numberOfRows(inSection: 0) * 56)
        }
        self.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(-24)
            $0.bottom.equalTo(commentTableView).offset(32)
        }
    }
}

//extension CommentView: UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 15
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: CommentTableViewCell.identifier,
//            for: indexPath
//        ) as? CommentTableViewCell else {
//            return UITableViewCell()
//        }
//        cell.setUp()
//        return cell
//    }
//}
