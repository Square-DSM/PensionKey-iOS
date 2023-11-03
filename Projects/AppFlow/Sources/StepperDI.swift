import Domain
import Data
import Presentation

public struct StepperDI {
    public static let shared = resolve()

    public let myPageViewModel: MyPageViewModel

    public let loginViewModel: LoginViewModel
    public let signupViewModel: SignupViewModel
    
    public let noticeViewModel: NoticeViewModel
    public let noticeDetailViewModel: NoticeDetailViewModel
    public let writeNoticeViewModel: WriteNoticeViewModel
    public let searchViewModel: SearchViewModel

    public let myPensionViewModel: MyPensionViewModel
    public let myNationalPensionDetailViewModel: MyNationalPensionDetailViewModel
    public let myHousingPensionViewModel: MyHousingPensionViewModel
    public let myPersonalPensionViewModel: MyPersonalPensionViewModel
}

extension StepperDI {
    private static func resolve() -> StepperDI {
        let serviceDI = ServiceDI.shared

        // MARK: User관련 ViewModel
        let myPageViewModel = MyPageViewModel(
            fetchUserInfoUseCase: serviceDI.fetchUserInfoUseCaseInject,
            fetchMyNoticeListUseCase: serviceDI.fetchMyNoticeListUseCaseInject
        )

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
            fetchNoticeDetailUseCase: serviceDI.fetchNoticeDetailUseCaseInject,
            fetchCommentListUseCase: serviceDI.fetchCommentListUseCaseInject,
            createCommentUseCase: serviceDI.createCommentUseCaseInject,
            deleteNoticeUseCase:  serviceDI.deleteNoticeUseCaseInject
        )
        let writeNoticeViewModel = WriteNoticeViewModel(
            createNoticeUseCase: serviceDI.createNoticeUseCaseInject
        )
        let searchViewModel = SearchViewModel(
            searchNoticeListUseCase: serviceDI.searchNoticeListUseCaseInject,
            searchKeyListUseCase: serviceDI.searchKeyListUseCaseInject
        )

        // MARK: Pension관련 ViewModel
        let myPensionViewModel = MyPensionViewModel(
            fetchNationalPensionListUseCase: serviceDI.fetchNationalPensionListInject,
            fetchHousingPensionListUseCase: serviceDI.fetchHousingPensionListInject,
            fetchPersonalPensionListUseCase: serviceDI.fetchPersonalPensionListInject,
            fetchUserInfoUseCase: serviceDI.fetchUserInfoUseCaseInject
        )
        let myNationalPensionDetailViewModel = MyNationalPensionDetailViewModel(
            fetchNationalPensionDetailListUseCase: serviceDI.fetchNationalPensionDetailListInject
        )
        let myHousingPensionViewModel = MyHousingPensionViewModel(
            fetchHousingPensionDetailListUseCase: serviceDI.fetchHousingPensionDetailListInject
        )
        let myPersonalPensionViewModel = MyPersonalPensionViewModel(
            FetchPersonalPensionDetailListUseCase: serviceDI.fetchPersonalPensionDetailListInject
        )
        

        return .init(
            myPageViewModel: myPageViewModel,
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel,
            noticeViewModel: noticeViewModel,
            noticeDetailViewModel: noticeDetailViewModel,
            writeNoticeViewModel: writeNoticeViewModel,
            searchViewModel: searchViewModel,
            myPensionViewModel: myPensionViewModel,
            myNationalPensionDetailViewModel: myNationalPensionDetailViewModel,
            myHousingPensionViewModel: myHousingPensionViewModel,
            myPersonalPensionViewModel: myPersonalPensionViewModel
        )
    }
}
