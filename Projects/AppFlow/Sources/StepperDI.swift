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

    public let myPensionViewModel: MyPensionViewModel
    public let myNationalPensionDetailViewModel: MyNationalPensionDetailViewModel
}

extension StepperDI {
    private static func resolve() -> StepperDI {
        let serviceDI = ServiceDI.shared

        // MARK: Auth관련 ViewModel
        let loginViewModel = LoginViewModel(
            loginUseCase: serviceDI.loginUseCaseInject
        )
        let signupViewModel = SignupViewModel(
            signupUseCase: serviceDI.signupUseCaseInject
        )
        // MARK: Notice관련 ViewModel
        let noticeViewModel = NoticeViewModel(
            fetchNoticeListUseCase: serviceDI.fetchNoticeListUseCaseInject
        )
        let noticeDetailViewModel = NoticeDetailViewModel(
            fetchNoticeDetailUseCase: serviceDI.fetchNoticeDetailUseCaseInject
        )
        let writeNoticeViewModel = WriteNoticeViewModel(
            createNoticeUseCase: serviceDI.createNoticeUseCaseInject
        )
        let searchViewModel = SearchViewModel()

        // MARK: Pension관련 ViewModel
        let myPensionViewModel = MyPensionViewModel(
            fetchNationalPensionListUseCase: serviceDI.fetchNationalPensionListInject,
            fetchHousingPensionListUseCase: serviceDI.fetchHousingPensionListInject,
            fetchPersonalPensionListUseCase: serviceDI.fetchPersonalPensionListInject
        )
        let myNationalPensionDetailViewModel = MyNationalPensionDetailViewModel(
            fetchNationalPensionDetailListUseCase: serviceDI.fetchNationalPensionDetailListInject
        )

        return .init(
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel,
            noticeViewModel: noticeViewModel,
            noticeDetailViewModel: noticeDetailViewModel,
            writeNoticeViewModel: writeNoticeViewModel,
            searchViewModel: searchViewModel,
            myPensionViewModel: myPensionViewModel,
            myNationalPensionDetailViewModel: myNationalPensionDetailViewModel
        )
    }
}
