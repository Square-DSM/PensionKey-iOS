import Foundation
import RxFlow

public enum PensionStep: Step {
    case loginRequire
    case signupRequire
    case tabsRequire
    case myPensionRequire
    case myPensionDetailRequire
    case noticeRequire
    case benefitRequire
    case myPageRequire
    case errorRequire
    case writeNoticeRequire
    case noticeDetailRequire
    case searchRequire
}
