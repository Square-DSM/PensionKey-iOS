import Foundation
import RxSwift
import RxCocoa
import Domain

class NoticeRepositoryImpl: NoticeRepository {
    let noticeDataSource = NoticeDataSource.shared

    func createNotice(title: String, content: String) -> RxSwift.Completable {
        return noticeDataSource.createNotice(title: title, content: content)
    }
    
    func fetchNoticeDetail(feedId: String) -> RxSwift.Single<Domain.NoticeDetailEntity> {
        return noticeDataSource.fetchNoticeDetail(feedId: feedId)
    }
    
    func deleteNotice(feedID: String) -> RxSwift.Completable {
        return noticeDataSource.deleteNotice(feedID: feedID)
    }
    
    func fetchNoticeList() -> RxSwift.Single<[Domain.NoticeEntity]> {
        return noticeDataSource.fetchNoticeList()
    }
    
    
}
