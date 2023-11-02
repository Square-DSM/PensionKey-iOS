import Domain

public struct ServiceDI {
    public static let shared = resolve()
    // User
    public let fetchUserInfo: FetchUserInfoUseCase
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

    // Search
    public let searchNoticeListUseCaseInject: SearchNoticeListUseCase
    public let searchKeyListUseCaseInject: SearchKeyListUseCase

    // Comment
    public let fetchCommentListUseCaseInject: FetchCommentListUseCase
    public let createCommentUseCaseInject: CreateCommentUseCase

}

extension ServiceDI {
    private static func resolve() -> ServiceDI {
        let userRepo = UserRepositoryImpl()
        let authRepo = AuthRepositoryImpl()
        let noticeRepo = NoticeRepositoryImpl()
        let pensionRepo = PensionRepositoryImpl()
        let commentRepo = CommentRepositoryImpl()

        // MARK: User관련 UseCase
        let fetchUserInfoInject = FetchUserInfoUseCase(repository: userRepo)

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)
        
        // MARK: Notice관련 UseCase
        let fetchNoticeDetailUseCaseInject = FetchNoticeDetailUseCase(repository: noticeRepo)
        let fetchNoticeListUseCaseInject = FetchNoticeListUseCase(repository: noticeRepo)
        let createNoticeUseCaseInject = CreateNoticeUseCase(repository: noticeRepo)
        let deleteNoticeUseCaseInject = DeleteNoticeUseCase(repository: noticeRepo)
        let searchNoticeListUseCaseInject = SearchNoticeListUseCase(repository: noticeRepo)
        let searchKeyListUseCaseInject = SearchKeyListUseCase(repository: noticeRepo)
        
        // MARK: Comment관련 UseCase
        let fetchCommentListUseCaseInject = FetchCommentListUseCase(repository: commentRepo)
        let createCommentUseCaseInject = CreateCommentUseCase(repository: commentRepo)

        // MARK: Pension관련 UseCase
        
        let fetchNationalPensionListInject = FetchNationalPensionListUseCase(repository: pensionRepo)
        let fetchHousingPensionListInject = FetchHousingPensionListUseCase(repository: pensionRepo)
        let fetchPersonalPensionListInject = FetchPersonalPensionListUseCase(repository: pensionRepo)
        let fetchNationalPensionDetailListInject = FetchNationalPensionDetailListUseCase(repository: pensionRepo)
        let fetchHousingPensionDetailListInject = FetchHousingPensionDetailListUseCase(repository: pensionRepo)
        let fetchPersonalPensionDetailListInject = FetchPersonalPensionDetailListUseCase(repository: pensionRepo)

        return .init(
            fetchUserInfo: fetchUserInfoInject,
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
            fetchPersonalPensionDetailListInject: fetchPersonalPensionDetailListInject,
            searchNoticeListUseCaseInject: searchNoticeListUseCaseInject,
            searchKeyListUseCaseInject: searchKeyListUseCaseInject,
            fetchCommentListUseCaseInject: fetchCommentListUseCaseInject,
            createCommentUseCaseInject: createCommentUseCaseInject
        )
    }
}
