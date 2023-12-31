import Foundation
import RxSwift

public class SignupUseCase {

    let repository: AuthRepository

    public init(repository: AuthRepository) {
        self.repository = repository
    }

    public func execute(accountID: String, password: String, name: String) -> Completable {
        return repository.signup(accountID: accountID, password: password, name: name)
    }
}
