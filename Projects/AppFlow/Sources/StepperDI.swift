import Domain
import Data
import Presentation

public struct StepperDI {
    public static let shared = resolve()

    public let loginViewModel: LoginViewModel
    public let signupViewModel: SignupViewModel
    
    public let noticeViewModel: NoticeViewModel
    public let noticeDetailViewModel: NoticeDetailViewModel
    public let writeNoticeViewModel: WriteNoticeViewModel
    public let searchViewModel: SearchViewModel
}

extension StepperDI {
    private static func resolve() -> StepperDI {
        let ServiceDI = ServiceDI.shared

        // MARK: Auth관련 UseCase
        let loginViewModel = LoginViewModel(
            loginUseCase: ServiceDI.loginUseCaseInject
        )
        let signupViewModel = SignupViewModel(
            signupUseCase: ServiceDI.signupUseCaseInject
        )
        // MARK: Notice관련 UseCase
        let noticeViewModel = NoticeViewModel(
            fetchNoticeListUseCase: ServiceDI.fetchNoticeListUseCaseInject
        )
        let noticeDetailViewModel = NoticeDetailViewModel(
            fetchNoticeDetailUseCase: ServiceDI.fetchNoticeDetailUseCaseInject,
            fetchCommentListUseCase: ServiceDI.fetchCommentListUseCaseInject,
            createCommentUseCase: ServiceDI.createCommentUseCaseInject,
            deleteNoticeUseCase:  ServiceDI.deleteNoticeUseCaseInject
        )
        let writeNoticeViewModel = WriteNoticeViewModel(
            createNoticeUseCase: ServiceDI.createNoticeUseCaseInject
        )
        let searchViewModel = SearchViewModel()

        return .init(
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel,
            noticeViewModel: noticeViewModel,
            noticeDetailViewModel: noticeDetailViewModel,
            writeNoticeViewModel: writeNoticeViewModel,
            searchViewModel: searchViewModel
        )
    }
}
