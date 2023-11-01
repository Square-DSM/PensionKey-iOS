import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class SignupViewController: BaseViewController<SignupViewModel> {
    private let logoImageView = UIImageView().then {
        $0.image = .logo
    }
    private let logoTitleLabel = UILabel().then {
        $0.text = "연금열쇠"
        $0.textColor = .gray500
        $0.font = .titleSmall
    }
    private let titleLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = .black
        $0.font = .titleLarge
    }
    private let nameTextField = AuthTextFieldView().then {
        $0.setUpView(
            title: "이름",
            placeholder: "이름을 입력해주세요."
        )
    }
    private let idTextField = AuthTextFieldView().then {
        $0.setUpView(
            title: "아이디",
            placeholder: "아이디를 입력해주세요."
        )
    }
    private let passwordTextField = AuthTextFieldView().then {
        $0.setUpView(
            title: "비밀번호",
            placeholder: "비밀번호를 입력해주세요."
        )
    }
    private let signupButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .yellow500
        $0.layer.cornerRadius = 6
        $0.titleLabel?.font = .titleSmall
    }
    private let loginLabel = UILabel().then {
        $0.text = "이미 회원이신가요?"
        $0.font = .bodySmall
        $0.textColor = .gray900
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.blue500, for: .normal)
        $0.titleLabel?.font = .labelSmall
    }
    public override func attribute() {
        self.navigationController?.isNavigationBarHidden = true
    }
    public override func bind() {
        let input = SignupViewModel.Input(loginButtonDidTap: loginButton.rx.tap.asSignal())
        _ = viewModel.transform(input)
    }
    
    public override func addView() {
        [
            logoImageView,
            logoTitleLabel,
            titleLabel,
            nameTextField,
            idTextField,
            passwordTextField,
            signupButton,
            loginLabel,
            loginButton
        ].forEach { self.view.addSubview($0) }
    }
    public override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(77)
            $0.leading.equalToSuperview().inset(18)
            $0.width.height.equalTo(32)
        }
        logoTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(4)
            $0.top.equalToSuperview().inset(82)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(64)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(74)
        }
        idTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(74)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(74)
        }
        signupButton.snp.makeConstraints {
            $0.bottom.equalTo(loginLabel.snp.top).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(46)
        }
        loginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().inset(58)
        }
        loginButton.snp.makeConstraints {
            $0.leading.equalTo(loginLabel.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().inset(58)
            $0.height.equalTo(18)
            $0.width.equalTo(49)
        }
    }
}
