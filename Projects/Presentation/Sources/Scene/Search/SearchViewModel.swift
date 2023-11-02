import UIKit
import Domain
import Core
import RxSwift
import RxCocoa
import RxFlow

public class SearchViewModel: BaseViewModel, Stepper {
    public var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let searchNoticeListUseCase: SearchNoticeListUseCase
    private let searchKeyListUseCase: SearchKeyListUseCase
    
    public init(
        searchNoticeListUseCase: SearchNoticeListUseCase,
        searchKeyListUseCase: SearchKeyListUseCase
    ) {
        self.searchNoticeListUseCase = searchNoticeListUseCase
        self.searchKeyListUseCase = searchKeyListUseCase
    }

    public struct Input {
        let searchResultTableViewCellDidTap: ControlEvent<IndexPath>
        let viewAppear: Signal<Void>
        let keywordText: Driver<String>
    }
    public struct Output {
        let noticeList: BehaviorRelay<[NoticeEntity]>
        let keywordList: BehaviorRelay<[SearchKeyEntity]>
    }

    public func transform(_ input: Input) -> Output {
        let noticeList = BehaviorRelay<[NoticeEntity]>(value: [])
        let keywordList = BehaviorRelay<[SearchKeyEntity]>(value: [])
        input.searchResultTableViewCellDidTap.asObservable()
            .map { PensionStep.noticeDetailRequire(id: noticeList.value[$0.row].id) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.keywordText.asObservable()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .flatMap { self.searchNoticeListUseCase.execute(keyword: $0) }
            .bind(to: noticeList)
            .disposed(by: disposeBag)

        input.viewAppear.asObservable()
            .withLatestFrom(input.keywordText)
            .filter { !$0.isEmpty }
            .flatMap { self.searchNoticeListUseCase.execute(keyword: $0) }
            .bind(to: noticeList)
            .disposed(by: disposeBag)

        input.viewAppear.asObservable()
            .flatMap { self.searchKeyListUseCase.execute() }
            .map {
                var removedArray = [SearchKeyEntity]()
                $0.forEach {
                    if !removedArray.contains($0) && !$0.keyword.isEmpty {
                        removedArray.append($0)
                    }
                }
                return removedArray
            }
            .bind(to: keywordList)
            .disposed(by: disposeBag)
        
        return Output(
            noticeList: noticeList,
            keywordList: keywordList
        )
    }
}
