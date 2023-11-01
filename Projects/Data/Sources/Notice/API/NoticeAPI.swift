import Foundation
import Moya
import Core

public enum NoticeAPI {
    case createNotice(title: String, content: String)
    case fetchNoticeDetail(feedId: String)
    case deleteNotice(feedId: String)
    case fetchNoticeList
}

extension NoticeAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .createNotice:
            return "/feeds/create"
        case .fetchNoticeDetail(let feedId):
            return "/feeds/\(feedId)"
        case .deleteNotice(let feedId):
            return "/feeds/delete/\(feedId)"
        case .fetchNoticeList:
            return "feeds/list"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .createNotice:
            return .post
        case .deleteNotice:
            return .delete
        case .fetchNoticeDetail, .fetchNoticeList:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .createNotice(let title, let content):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "content": content
                ],
                encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
