import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow
import PensionKeyKit
import Core
import Kingfisher

public class BenefitViewController: BaseViewController<BenefitViewModel> {
    private let scrollerView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.bounces = false
    }

    private let imageView1 = UIImageView()
    private let imageView2 = UIImageView()
    private let imageView3 = UIImageView()

    public override func attribute() {
        let url1 = URL(string: "http://insurancesupport.or.kr/data/files/2102/c2c7fac139b779e13d93bf2cda939a9f_1612227459_8532.png")
        let url2 = URL(string: "http://insurancesupport.or.kr/data/files/2301/9a1d74d3dd55dd772442202143c87bb0_1674029014_8925.png")
        let url3 = URL(string: "https://cdn.enewstoday.co.kr/news/photo/202307/2015971_815968_3631.jpg")
        imageView1.kf.setImage(with: url1)
        imageView2.kf.setImage(with: url2)
        imageView3.kf.setImage(with: url3)
    }

    public override func addView() {
        view.addSubview(scrollerView)
        [
            imageView1,
            imageView2,
            imageView3
        ].forEach {
            scrollerView.addSubview($0)
        }
    }

    public override func setLayout() {
        scrollerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView1.snp.makeConstraints {
            $0.top.width.equalToSuperview()
        }
        imageView2.snp.makeConstraints {
            $0.top.equalTo(imageView1.snp.bottom).offset(2)
            $0.width.equalToSuperview()
        }
        imageView3.snp.makeConstraints {
            $0.top.equalTo(imageView2.snp.bottom).offset(2)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
