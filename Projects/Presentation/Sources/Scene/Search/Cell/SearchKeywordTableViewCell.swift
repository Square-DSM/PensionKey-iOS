import UIKit
import SnapKit
import Then
import RxSwift
import PensionKeyKit

class SearchKeywordTableViewCell: UITableViewCell {

    static let identifier = "searchKeywordTableViewCell"

    let keywordLabel = UILabel().then {
        $0.textColor = .gray600
        $0.font = .bodyMedium
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [
            keywordLabel
        ].forEach {
            addSubview($0)
        }
        keywordLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
            $0.height.equalTo(22)
        }
    }

    public func settingCell(keyword: String) {
        self.keywordLabel.text = keyword
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
