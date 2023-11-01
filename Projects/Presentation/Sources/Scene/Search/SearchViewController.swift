import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class SearchViewController: BaseViewController<SearchViewModel> {

    let dummyKeyWords = BehaviorRelay(value: [
        "국민 연금",
        "연금",
        "국민 연금 납부 금액"
    ])

    private let titleViewLabel = UILabel().then {
        $0.text = "게시글 검색"
        $0.textColor = .black
        $0.font = .bodyMedium
    }

    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "게시글을 검색해 보세요"
        $0.searchBar.tintColor = .yellow500
        $0.searchBar.searchTextField.font = .bodyMedium
        $0.searchBar.showsCancelButton = false
        $0.hidesNavigationBarDuringPresentation = false
    }

    // MARK: Search Keyword
    private let searchKeywordView = UIView().then {
        $0.backgroundColor = .white
    }
    private let searchKeywordMarkLabel = UILabel().then {
        $0.text = "최근 검색어"
        $0.textColor = .black
        $0.font = .titleSmall
    }
    private let searchKeywordTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        $0.register(SearchKeywordTableViewCell.self, forCellReuseIdentifier: SearchKeywordTableViewCell.identifier)
    }

    // MARK: Search Result
    private let searchResultView = UIView().then {
        $0.backgroundColor = .white
    }
    private let searchResultMarkLabel = UILabel().then {
        $0.text = "검색된 게시글"
        $0.textColor = .black
        $0.font = .titleSmall
    }
    private let searchResultNumberLabel = UILabel().then {
        $0.text = "4"
        $0.textColor = .yellow500
        $0.font = .titleSmall
    }
    private let searchResultTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset.left = 0
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        $0.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
    }

    private let resultEmptyView = UIView().then {
        $0.backgroundColor = .gray50
    }
    private let resultEmptyLabel = UILabel().then {
        $0.textColor = .gray500
        $0.font = .titleSmall
    }

    public override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    public override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    public override func attribute() {
        self.navigationItem.searchController = searchController
        self.navigationItem.titleView = titleViewLabel
    }

    public override func addView() {
        [
            resultEmptyView,
            searchResultView,
            searchKeywordView
        ].forEach { view.addSubview($0) }

        // Search Keyword
        [
            searchKeywordMarkLabel,
            searchKeywordTableView
        ].forEach { searchKeywordView.addSubview($0) }

        // Search Result
        [
            searchResultMarkLabel,
            searchResultNumberLabel,
            searchResultTableView
        ].forEach { searchResultView.addSubview($0) }

        // Result Empty
        resultEmptyView.addSubview(resultEmptyLabel)
    }

    public override func setLayout() {
        searchKeywordView.snp.makeConstraints {
            $0.width.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        searchKeywordMarkLabel.snp.makeConstraints {
            $0.topMargin.equalTo(18)
            $0.leadingMargin.equalTo(20)
            $0.height.equalTo(38)
        }
        searchKeywordTableView.snp.makeConstraints {
            $0.top.equalTo(searchKeywordMarkLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }

        searchResultView.snp.makeConstraints {
            $0.width.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        searchResultMarkLabel.snp.makeConstraints {
            $0.topMargin.equalTo(18)
            $0.leadingMargin.equalTo(20)
            $0.height.equalTo(38)
        }
        searchResultNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(searchResultMarkLabel)
            $0.leading.equalTo(searchResultMarkLabel.snp.trailing).offset(4)
            $0.height.equalTo(22)
        }
        searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(searchKeywordMarkLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }

        resultEmptyView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.bottom.equalToSuperview()
        }
        resultEmptyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(22)
        }
    }

    public override func bind() {
        dummyKeyWords.asObservable()
            .bind(to: searchKeywordTableView.rx.items(cellIdentifier: SearchKeywordTableViewCell.identifier, cellType: SearchKeywordTableViewCell.self)) { (index, element, cell) in
                cell.keywordLabel.text = element
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)

        dummyKeyWords.asObservable()
            .bind(to: searchResultTableView.rx.items(cellIdentifier: NoticeTableViewCell.identifier, cellType: NoticeTableViewCell.self)) { (index, element, cell) in
                cell.titleLabel.text = element
                cell.selectionStyle = .none
                cell.setUp()
            }
            .disposed(by: disposeBag)

        searchController.searchBar.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [weak self] text in
                self?.searchKeywordView.isHidden = !text.isEmpty
                self?.searchResultView.isHidden = self?.searchResultTableView.numberOfRows(inSection: 0) == 0
                let emptyText: String = {
                    var str: String
                    if text.count > 10 {
                        str = "\(text.prefix(10))..."
                    } else { str = text }
                    str.append("에 대한 게시글이 없어요.")
                    return str
                }()
                self?.resultEmptyLabel.text = emptyText
            }
            .disposed(by: disposeBag)

        searchKeywordTableView.rx.itemSelected
            .map { index -> String? in
                guard let cell = self.searchKeywordTableView.cellForRow(at: index) as? SearchKeywordTableViewCell else { return nil }

                return cell.keywordLabel.text
            }
            .bind(to: searchController.searchBar.searchTextField.rx.text)
            .disposed(by: disposeBag)
    }
}
