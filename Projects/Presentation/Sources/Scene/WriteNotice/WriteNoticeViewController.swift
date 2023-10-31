import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class WriteNoticeViewController: BaseViewController<WriteNoticeViewModel> {
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
    public override func attribute() {
        setNavigationBar()
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
    }

    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: registrationButton)
        self.navigationItem.titleView = titleLabel
    }
    public override func addView() {
        [
            titleTextField,
            contentTextView
        ].forEach { self.view.addSubview($0) }
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
    }
}
