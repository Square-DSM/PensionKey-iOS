import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core

public class NoticeViewController: BaseViewController<NoticeViewModel> {
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
        $0.separatorStyle = .singleLine
        $0.separatorColor = .gray100
    }
    public override func attribute() {
        noticeTableView.dataSource = self
        noticeTableView.delegate = self
        setNavigationBar()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    public override func bind() {
        let input = NoticeViewModel.Input(
            writeNotcieButtonDidTap: writeNoticeButton.rx.tap.asSignal(),
            noticeTableViewCellDidTap: noticeTableView.rx.itemSelected
        )
        _ = viewModel.transform(input)
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

extension NoticeViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoticeTableViewCell.identifier,
            for: indexPath
        ) as? NoticeTableViewCell else { return UITableViewCell() }
        let list = ["국민연금이 뭔가요?", "기초생활 수급자도 국민연금에 가입할 수 있나요?", "물가가 오르면 연금액도 올라가나요?"]
        cell.titleLabel.text = list[indexPath.row]
        cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        cell.selectionStyle = .none
        cell.setUp()
        return cell
    }
}
