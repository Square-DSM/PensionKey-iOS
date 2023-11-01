import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class WriteNoticeViewController: BaseViewController<WriteNoticeViewModel> {

    private let registerNotice = PublishRelay<Void>()

    private let titleLabel = UILabel().then {
        $0.text = "게시글 작성"
        $0.font = .bodyMedium
    }
    private let registrationButton = UIButton(type: .system).then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.yellow700, for: .normal)
        $0.backgroundColor = .yellow100
        $0.layer.cornerRadius = 6
        $0.frame = .init(x: 0, y: 0, width: 41, height: 26)
    }
    let titleTextField = UITextField().then {
        $0.placeholder = "제목"
        $0.tintColor = .gray300
        $0.font = .titleMedium
    }
    let contentTextView = UITextView().then {
        $0.text = "내용을 입력해주세요."
        $0.textColor = .gray300
        $0.font = .bodyMedium
        $0.contentInset = .init(top: 12, left: -5, bottom: 0, right: 0)
    }

    private let bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    private let bottomLineView = UIView().then {
        $0.backgroundColor = .gray100
    }
    private let bottomRegisterButton = UIButton(type: .system).then {
        $0.setImage(.send, for: .normal)
        $0.tintColor = .yellow500
    }

    public override func bind() {
        let input = WriteNoticeViewModel.Input(
            registerButtonSignal: registerNotice.asSignal(),
            titleDriber: titleTextField.rx.text.orEmpty.asDriver(),
            contentsDriber: contentTextView.rx.text.orEmpty.asDriver()
        )

        let output = viewModel.transform(input)

        output.isRegisterAble
            .emit(
                with: self,
                onNext: { owner, isAble in
                    owner.registrationButton.isEnabled = isAble
                    owner.bottomRegisterButton.isEnabled = isAble
                }
            )
            .disposed(by: disposeBag)
    }
    
    public override func attribute() {

        setNavigationBar()
        keyboardNotification()
        self.tabBarController?.tabBar.isHidden = true

        contentTextView.rx.didBeginEditing.asObservable()
                .subscribe(onNext: {
                    if self.contentTextView.text == "내용을 입력해주세요." {
                        self.contentTextView.text = ""
                        self.contentTextView.textColor = .black
                    }
                }).disposed(by: disposeBag)
        contentTextView.rx.didEndEditing.asObservable()
            .subscribe(onNext: {
                if self.contentTextView.text == "" {
                    self.contentTextView.text = "내용을 입력해주세요."
                    self.contentTextView.textColor = .gray300
                }
            }).disposed(by: disposeBag)

        bottomRegisterButton.rx.tap
            .bind(to: registerNotice)
            .disposed(by: disposeBag)

        registrationButton.rx.tap
            .bind(to: registerNotice)
            .disposed(by: disposeBag)
    }

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: registrationButton)
        self.navigationItem.titleView = titleLabel
    }
    public override func addView() {
        [
            titleTextField,
            contentTextView,
            bottomView
        ].forEach { self.view.addSubview($0) }
        [
            bottomLineView,
            bottomRegisterButton
        ].forEach { bottomView.addSubview($0) }
    }
    public override func setLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.topMargin)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }

        bottomView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        bottomLineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(1)
        }
        bottomRegisterButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
    }

    private func keyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardControl(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardControl(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardControl(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }

        if sender.name == UIResponder.keyboardWillShowNotification {
            let moveTo = -keyboardFrame.height + view.safeAreaInsets.bottom
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: moveTo)
        } else {
            self.bottomView.transform = .identity
        }
    }
}
