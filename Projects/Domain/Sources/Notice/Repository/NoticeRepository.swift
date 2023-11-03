import Foundation
import RxSwift

public protocol NoticeRepository {
    func createNotice(title: String, content: String) -> Completable

    func fetchNoticeDetail(feedId: String) -> Single<NoticeDetailEntity>

    func deleteNotice(feedID: String) -> Completable

    func fetchNoticeList() -> Single<[NoticeEntity]>

    func searchNoticeList(keyword: String) -> Single<[NoticeEntity]>

    func searchKeyList() -> Single<[SearchKeyEntity]>

    func fetchMyNoticeList() -> Single<[NoticeEntity]>
}
