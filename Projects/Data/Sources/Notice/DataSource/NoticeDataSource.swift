import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger
import Domain

class NoticeDataSource {

    private let provider = MoyaProvider<NoticeAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = NoticeDataSource()
    private init() {}

    func createNotice(title: String, content: String) -> Completable {
        return provider.rx.request(.createNotice(title: title, content: content))
            .asCompletable()
    }

    func fetchNoticeDetail(feedId: String) -> Single<NoticeDetailEntity> {
        return provider.rx.request(.fetchNoticeDetail(feedId: feedId))
            .map(NoticeDetailDTO.self)
            .map { $0.toDomain() }
    }

    func deleteNotice(feedID: String) -> Completable {
        return provider.rx.request(.deleteNotice(feedId: feedID))
            .asCompletable()
    }

    func fetchNoticeList() -> Single<[NoticeEntity]> {
        return provider.rx.request(.fetchNoticeList)
            .map(NoticeListDTO.self)
            .map { $0.toDomain() }
    }

    func searchNoticeList(keyword: String) -> Single<[NoticeEntity]> {
        return provider.rx.request(.searchNoticeList(keyword: keyword))
            .map(NoticeListDTO.self)
            .map { $0.toDomain() }
    }

    func searchKeyList() -> Single<[SearchKeyEntity]> {
        return provider.rx.request(.searchKeyList)
            .map(SearchKeyListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchMyNoticeList() -> Single<[NoticeEntity]> {
        return provider.rx.request(.fetchMyNoticeList)
            .map(NoticeListDTO.self)
            .map { $0.toDomain() }
    }
}
