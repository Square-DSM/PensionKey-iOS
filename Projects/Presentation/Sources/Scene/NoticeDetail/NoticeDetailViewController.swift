import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core
import Domain

public class NoticeDetailViewController: BaseViewController<NoticeDetailViewModel> {
    public var id: String = ""
    private let viewAppear = PublishRelay<Void>()
    private let deletePostRelay = PublishRelay<Void>()

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    public let profileView = ProfileView()

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

    public override func attribute() {
        settingAlertAndMenu()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewAppear.accept(())
    }

    public override func bind() {
        let input = NoticeDetailViewModel.Input(
            id: id,
            viewAppear: viewAppear.asSignal(),
            commentText: commentView.commentTextField.rx.text.orEmpty.asDriver(),
            deletePostButtonDidClick: deletePostRelay.asSignal(),
            commentRegisterButtonDidTap: commentView.registerButton.rx.tap.asSignal()
        )

        let output = viewModel.transform(input)
        output.noticeDetailData.asObservable()
            .bind(onNext: { [self] in
                titleLabel.text = $0.title
                contentLabel.text = $0.content
                profileView.idLabel.text = $0.userAccountId
                profileView.dateLabel.text = $0.createdAt.getTimeAgoAsKoreanString()
            }).disposed(by: disposeBag)
        output.commentListData
            .do(onNext: { [self] in
                self.commentView.countLabel.text = "\($0.count)"
            })
            .bind(to: commentView.commentTableView.rx.items(
            cellIdentifier: CommentTableViewCell.identifier,
            cellType: CommentTableViewCell.self
        )) { row, item, cell in
            cell.commentLabel.text = item.content
            cell.idAndDateLabel.text = "\(item.userAccountId) · \(item.createdAt.getTimeAgoAsKoreanString())"
        }.disposed(by: disposeBag)
        output.reloadView.subscribe(onNext: { [self] in
            self.viewAppear.accept(())
        }).disposed(by: disposeBag)
        output.isEmpty.asObservable()
            .subscribe(onNext: { [self] in
                commentView.registerButton.isEnabled = $0
                if $0 {
                    commentView.registerButton.backgroundColor = .yellow100
                } else {
                    commentView.registerButton.backgroundColor = .gray50
                }
            })
            .disposed(by: disposeBag)
    }

    public override func addView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            profileView,
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
            $0.bottom.equalTo(commentView.snp.bottom).offset(32)
        }
        profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.height.equalTo(64)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(12)
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
            $0.top.equalTo(spacerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func settingAlertAndMenu() {
        let deleteAlert = UIAlertController(
            title: "게시글 삭제",
            message: "정말 게시글을 삭제하실건가요?",
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.deletePostRelay.accept(())
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [
            alertAction,
            cancelAction
        ].forEach { deleteAlert.addAction($0) }

        let deleteAction = UIAction(
            title: "게시글 삭제",
            image: .trashCan,
            handler: { _ in self.present(deleteAlert, animated: true)}
        )
        let moreMenu = UIMenu(
            title: "",
            image: nil,
            identifier: nil,
            options: .destructive,
            children: [deleteAction]
        )
        profileView.moreButton.menu = moreMenu
    }
}
