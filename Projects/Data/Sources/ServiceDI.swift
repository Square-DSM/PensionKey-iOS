import Domain

public struct ServiceDI {
    public static let shared = resolve()
    // Auth
    public let loginUseCaseInject: LoginUseCase
    public let signupUseCaseInject: SignupUseCase
    // Norice
    public let fetchNoticeDetailUseCaseInject: FetchNoticeDetailUseCase
    public let fetchNoticeListUseCaseInject: FetchNoticeListUseCase
    public let createNoticeUseCaseInject: CreateNoticeUseCase
    public let deleteNoticeUseCaseInject: DeleteNoticeUseCase
    //Pension
    public let fetchNationalPensionListInject: FetchNationalPensionListUseCase
    public let fetchHousingPensionListInject: FetchHousingPensionListUseCase
    public let fetchPersonalPensionListInject: FetchPersonalPensionListUseCase
    public let fetchNationalPensionDetailListInject: FetchNationalPensionDetailListUseCase
    public let fetchHousingPensionDetailListInject: FetchHousingPensionDetailListUseCase
    public let fetchPersonalPensionDetailListInject: FetchPersonalPensionDetailListUseCase
}

extension ServiceDI {
    private static func resolve() -> ServiceDI {
        let authRepo = AuthRepositoryImpl()
        let noticeRepo = NoticeRepositoryImpl()
        let pensionRepo = PensionRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)
        
        // MARK: Notice관련 UseCase
        let fetchNoticeDetailUseCaseInject = FetchNoticeDetailUseCase(repository: noticeRepo)
        let fetchNoticeListUseCaseInject = FetchNoticeListUseCase(repository: noticeRepo)
        let createNoticeUseCaseInject = CreateNoticeUseCase(repository: noticeRepo)
        let deleteNoticeUseCaseInject = DeleteNoticeUseCase(repository: noticeRepo)

        // MARK: Pension관련 UseCase
        
        let fetchNationalPensionListInject = FetchNationalPensionListUseCase(repository: pensionRepo)
        let fetchHousingPensionListInject = FetchHousingPensionListUseCase(repository: pensionRepo)
        let fetchPersonalPensionListInject = FetchPersonalPensionListUseCase(repository: pensionRepo)
        let fetchNationalPensionDetailListInject = FetchNationalPensionDetailListUseCase(repository: pensionRepo)
        let fetchHousingPensionDetailListInject = FetchHousingPensionDetailListUseCase(repository: pensionRepo)
        let fetchPersonalPensionDetailListInject = FetchPersonalPensionDetailListUseCase(repository: pensionRepo)

        return .init(
            loginUseCaseInject: loginUseCaseInject,
            signupUseCaseInject: signupUseCaseInject,
            fetchNoticeDetailUseCaseInject: fetchNoticeDetailUseCaseInject,
            fetchNoticeListUseCaseInject: fetchNoticeListUseCaseInject,
            createNoticeUseCaseInject: createNoticeUseCaseInject,
            deleteNoticeUseCaseInject: deleteNoticeUseCaseInject,
            fetchNationalPensionListInject: fetchNationalPensionListInject,
            fetchHousingPensionListInject: fetchHousingPensionListInject,
            fetchPersonalPensionListInject: fetchPersonalPensionListInject,
            fetchNationalPensionDetailListInject: fetchNationalPensionDetailListInject,
            fetchHousingPensionDetailListInject: fetchHousingPensionDetailListInject,
            fetchPersonalPensionDetailListInject: fetchPersonalPensionDetailListInject
        )
    }
}
