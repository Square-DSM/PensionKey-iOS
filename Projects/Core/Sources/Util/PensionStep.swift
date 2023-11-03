import Foundation
import RxFlow

public enum PensionStep: Step {
    case loginRequire
    case signupRequire
    case tabsRequire
    case myPensionRequire
    
    case myNationalPensionDetailRequire
    case myPersonalPensionDetailRequire(id: String)
    case myHousingPensionDetailRequire(id: String)
    
    case noticeRequire
    case benefitRequire
    case myPageRequire
    case errorRequire
    case writeNoticeRequire
    case noticeDetailRequire(id: String)
    case searchRequire
}
