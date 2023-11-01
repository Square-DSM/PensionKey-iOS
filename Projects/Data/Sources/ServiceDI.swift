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
}

extension ServiceDI {
    private static func resolve() -> ServiceDI {
        let authRepo = AuthRepositoryImpl()
        let noticeRepo = NoticeRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)
        
        // MARK: Notice관련 UseCase
        let fetchNoticeDetailUseCaseInject = FetchNoticeDetailUseCase(repository: noticeRepo)
        let fetchNoticeListUseCaseInject = FetchNoticeListUseCase(repository: noticeRepo)
        let createNoticeUseCaseInject = CreateNoticeUseCase(repository: noticeRepo)
        let deleteNoticeUseCaseInject = DeleteNoticeUseCase(repository: noticeRepo)

        return .init(
            loginUseCaseInject: loginUseCaseInject,
            signupUseCaseInject: signupUseCaseInject,
            fetchNoticeDetailUseCaseInject: fetchNoticeDetailUseCaseInject,
            fetchNoticeListUseCaseInject: fetchNoticeListUseCaseInject,
            createNoticeUseCaseInject: createNoticeUseCaseInject,
            deleteNoticeUseCaseInject: deleteNoticeUseCaseInject
        )
    }
}
