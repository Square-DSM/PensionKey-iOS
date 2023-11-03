import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class MyPageViewController: BaseViewController<MyPageViewModel> {

    private let viewDidLoadRelay = PublishRelay<Void>()

    private let navigationTitleLable = UILabel().then {
        $0.text = "마이페이지"
        $0.textColor = .black
        $0.font = .titleMedium
    }

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.bounces = false
    }

    private let contentView = UIView().then {
        $0.backgroundColor = .gray50
    }

    // MARK: Profile View

    private let profileView = UIView().then {
        $0.backgroundColor = .white
    }

    private let profileImageView = UIImageView().then {
        $0.image = .logoDark
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 50
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }

    private let userNameLabel = UILabel().then {
        $0.text = "박주영"
        $0.textColor = .black
        $0.font = .titleMedium
    }

    private let userIdLabel = UILabel().then {
        $0.text = "park01"
        $0.textColor = .gray700
        $0.font = .bodyMedium
    }

    private let profileEditButton = UIButton(type: .system).then {
        $0.backgroundColor = .gray50
        $0.setTitle("프로필 수정하기", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .labelSmall
        $0.layer.cornerRadius = 6
    }

    // MARK: MyPostView

    private let myPostView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let myPostMarkLabel = UILabel().then {
        $0.text = "내가 작성한 게시글"
        $0.textColor = .black
        $0.font = .titleSmall
    }

    private let myPostEmptyMarkLabel = UILabel().then {
        $0.text = "작성한 게시글이 아직 없어요"
        $0.textColor = .gray500
        $0.font = .bodyMedium
    }

    private let myPostTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.tableHeaderView = UIView()
        $0.separatorInset.left = 0
        $0.backgroundColor = .clear
    }

    // MARK: Setting view

    private let settingView = UIView().then {
        $0.backgroundColor = .white
    }

    private let settingMarkLabel = UILabel().then {
        $0.text = "설정"
        $0.textColor = .black
        $0.font = .titleSmall
    }

    private let settingItemStackView = UIStackView().then {
        $0.axis = .vertical
    }

    private let changePasswordButtonItem = UIButton(type: .system).then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .bodyMedium
        $0.setImage(.changeLock.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    private let logoutButtonItem = UIButton(type: .system).then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.red500, for: .normal)
        $0.titleLabel?.font = .bodyMedium
        $0.setImage(.quit.withTintColor(.red500, renderingMode: .alwaysOriginal), for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    private let deleteAccountButtonItem = UIButton(type: .system).then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setTitleColor(.red500, for: .normal)
        $0.titleLabel?.font = .bodyMedium
        $0.setImage(.manWithXmark.withTintColor(.red500, renderingMode: .alwaysOriginal), for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    public override func viewDidAppear(_ animated: Bool) {
        viewDidLoadRelay.accept(())
    }

    public override func attribute() {
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleLable)
    }

    public override func bind() {
        let input = MyPageViewModel.Input(viewDidLoad: viewDidLoadRelay.asSignal())
        let output = viewModel.transform(input)

        output.userInfoData.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, info in
                    owner.userNameLabel.text = info.name
                    owner.userIdLabel.text = info.accountId
            }, onError: { owner, err in
                print(err)
            })
            .disposed(by: disposeBag)
        output.myNoticeList
            .do(onNext: {
                self.myPostEmptyMarkLabel.isHidden = !$0.isEmpty
            })
            .bind(to: self.myPostTableView.rx.items(
            cellIdentifier: NoticeTableViewCell.identifier,
            cellType: NoticeTableViewCell.self
        )) { row, item, cell in
            cell.titleLabel.text = item.title
            cell.idAndDateLabel.text = "\(item.userAccountId) · \(item.createdAt.getTimeAgoAsKoreanString())"
            cell.commentStateView.commentStateLabel.text = "\(item.commentCount)"
            cell.id = item.id
            cell.selectionStyle = .none
            cell.setUp()
        }.disposed(by: disposeBag)
    }

    // MARK: AddView
    public override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            profileView,
            myPostView,
            settingView
        ].forEach { contentView.addSubview($0) }

        // profile
        [
            profileImageView,
            userNameLabel,
            userIdLabel,
            profileEditButton
        ].forEach { profileView.addSubview($0) }

        // myPost
        [
            myPostMarkLabel,
            myPostTableView,
            myPostEmptyMarkLabel
        ].forEach { myPostView.addSubview($0) }
    
        // setting
        [
            settingMarkLabel,
            settingItemStackView
        ].forEach { settingView.addSubview($0) }

        [
            changePasswordButtonItem,
            logoutButtonItem,
            deleteAccountButtonItem
        ].forEach { settingItemStackView.addArrangedSubview($0) }
    }

    // MARK: SetLayout
    public override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(settingView)
        }

        // profile
        profileView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.equalTo(profileEditButton).offset(24)
        }
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(24)
        }
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(18)
            $0.centerY.equalTo(profileImageView.snp.centerY).offset(-16)
            $0.height.equalTo(32)
        }
        userIdLabel.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(3)
            $0.height.equalTo(22)
        }
        profileEditButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(profileImageView.snp.bottom).offset(32)
            $0.height.equalTo(38)
        }

        // MyPost
        myPostView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(8)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(myPostTableView.snp.bottom).offset(24)
            $0.height.lessThanOrEqualTo(360).priority(999)
        }
        myPostMarkLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        myPostEmptyMarkLabel.snp.makeConstraints {
            $0.center.equalTo(myPostTableView.snp.center)
        }
        myPostTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(myPostMarkLabel.snp.bottom).offset(12)
            $0.height.greaterThanOrEqualTo(160).priority(1000)
            $0.height.greaterThanOrEqualTo(myPostTableView.contentSize.height).priority(998)
        }

        // Setting
        settingView.snp.makeConstraints {
            $0.top.equalTo(myPostView.snp.bottom).offset(8)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(settingItemStackView.snp.bottom).offset(24)
        }
        settingMarkLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        changePasswordButtonItem.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        logoutButtonItem.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        deleteAccountButtonItem.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        settingItemStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(settingMarkLabel.snp.bottom).offset(12)
        }
    }
}
