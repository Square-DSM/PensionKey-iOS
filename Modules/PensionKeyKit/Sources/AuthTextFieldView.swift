import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

public class AuthTextFieldView: UIView {
    private let disposeBag = DisposeBag()
    public let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .titleSmall
    }
    public let textField = UITextField().then {
        $0.font = .bodyMedium
        $0.textColor = .black
        $0.layer.cornerRadius = 6
        $0.backgroundColor = .gray50
        $0.addLeftPadding(size: 12)
    }
    public let secureButton = UIButton(type: .system).then {
        $0.setImage(.eye, for: .normal)
        $0.tintColor = .gray400
    }
    public func setUpView(title: String, placeholder: String, isSecure: Bool = false) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        [
            titleLabel,
            textField
        ].forEach { addSubview($0) }
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(46)
        }
        if isSecure {
            textField.addSubview(secureButton)
            secureButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(12)
                $0.width.height.equalTo(20)
            }
            secureButton.rx.tap
                .bind(onNext: {
                    self.textField.isSecureTextEntry.toggle()
                }).disposed(by: disposeBag)
        }
    }
}
