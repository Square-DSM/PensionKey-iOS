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
    // Comment
    public let fetchCommentListUseCaseInject: FetchCommentListUseCase
    public let createCommentUseCaseInject: CreateCommentUseCase
}

extension ServiceDI {
    private static func resolve() -> ServiceDI {
        let authRepo = AuthRepositoryImpl()
        let noticeRepo = NoticeRepositoryImpl()
        let commentRepo = CommentRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)
        
        // MARK: Notice관련 UseCase
        let fetchNoticeDetailUseCaseInject = FetchNoticeDetailUseCase(repository: noticeRepo)
        let fetchNoticeListUseCaseInject = FetchNoticeListUseCase(repository: noticeRepo)
        let createNoticeUseCaseInject = CreateNoticeUseCase(repository: noticeRepo)
        let deleteNoticeUseCaseInject = DeleteNoticeUseCase(repository: noticeRepo)
        
        // MARK: Comment관련 UseCase
        let fetchCommentListUseCaseInject = FetchCommentListUseCase(repository: commentRepo)
        let createCommentUseCaseInject = CreateCommentUseCase(repository: commentRepo)

        return .init(
            loginUseCaseInject: loginUseCaseInject,
            signupUseCaseInject: signupUseCaseInject,
            fetchNoticeDetailUseCaseInject: fetchNoticeDetailUseCaseInject,
            fetchNoticeListUseCaseInject: fetchNoticeListUseCaseInject,
            createNoticeUseCaseInject: createNoticeUseCaseInject,
            deleteNoticeUseCaseInject: deleteNoticeUseCaseInject,
            fetchCommentListUseCaseInject: fetchCommentListUseCaseInject,
            createCommentUseCaseInject: createCommentUseCaseInject
        )
    }
}
