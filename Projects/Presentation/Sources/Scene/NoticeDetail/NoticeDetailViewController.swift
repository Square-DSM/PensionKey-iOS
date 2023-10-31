import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class NoticeDetailViewController: BaseViewController<NoticeDetailViewModel> {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    public let profileView = ProfileView()
    let imageView = UIImageView().then {
        $0.image = .checkmark
    }
    public let titleLabel = UILabel().then {
        $0.text = "국민연금이 뭔가요?"
        $0.font = .titleMedium
        $0.textColor = .black
    }
    public let contentLabel = UILabel().then {
        $0.text = "인터넷에 찾아봤는데 잘 모르겠어요.\n혹시 이해하기 쉽게 설명해 주실 분 있나요?"
        $0.numberOfLines = 100
        $0.font = .bodyMedium
        $0.textColor = .gray900
    }
    public let spacerView = UIView().then {
        $0.backgroundColor = .gray50
    }

    public let commentView = CommentView()

    public override func addView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            profileView,
            imageView,
            titleLabel,
            contentLabel,
            spacerView,
            commentView
        ].forEach { self.contentView.addSubview($0) }
    }
    public override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(commentView).offset(32)
        }
        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.height.equalTo(64)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(199)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        spacerView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(44)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }
        commentView.snp.makeConstraints {
            $0.top.equalTo(spacerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
