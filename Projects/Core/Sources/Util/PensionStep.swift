import Foundation
import RxFlow

public enum PensionStep: Step {
    case loginRequire
    case tabsRequire
    case myPensionRequire
    case myPensionDetailRequire
    case noticeRequire
    case benefitRequire
    case myPageRequire
    case writeNoticeRequire
    case noticeDetailRequire
}
