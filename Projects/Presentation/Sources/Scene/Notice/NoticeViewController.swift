import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class NoticeViewController: BaseViewController<NoticeViewModel> {
    let viewAppear = PublishRelay<Void>()
    private let titleLabel = UILabel().then {
        $0.text = "게시판"
        $0.font = .titleMedium
    }
    private let searchButton = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "magnifyingglass"), for: .normal)
    }
    private let writeNoticeButton = UIButton(type: .system).then {
        $0.setImage(.pencil, for: .normal)
        $0.backgroundColor = .yellow400
        $0.layer.cornerRadius = 15
        $0.frame = .init(x: 0, y: 0, width: 30, height: 30)
    }
    private let noticeTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
        $0.tableHeaderView = UIView()
        $0.separatorInset.left = 0
    }
    public override func attribute() {
        setNavigationBar()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.viewAppear.accept(())
    }
    public override func bind() {
        let input = NoticeViewModel.Input(
            viewAppear: viewAppear.asSignal(),
            writeNotcieButtonDidTap: writeNoticeButton.rx.tap.asSignal(),
            searchButtonDidTap: searchButton.rx.tap.asSignal(),
            noticeTableViewCellDidTap: noticeTableView.rx.itemSelected
        )
        let output = viewModel.transform(input)
        output.noticeList.asObservable()
            .bind(to: noticeTableView.rx.items(
                cellIdentifier: NoticeTableViewCell.identifier,
                cellType: NoticeTableViewCell.self
            )) { row, item, cell in
                cell.titleLabel.text = item.title
                cell.idAndDateLabel.text = "\(item.userAccountId) · \(item.createdAt)"
//                cell.commentStateView.text =
                cell.id = item.id
                cell.selectionStyle = .none
                cell.setUp()
            }.disposed(by: disposeBag)
    }

    private func setNavigationBar() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 16
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: writeNoticeButton),
            spacer,
            UIBarButtonItem(customView: searchButton)
        ]
    }
    public override func addView() {
        self.view.addSubview(noticeTableView)
    }
    public override func setLayout() {
        noticeTableView.snp.makeConstraints {
            $0.topMargin.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottomMargin.equalToSuperview().inset(12)
        }
    }
}
