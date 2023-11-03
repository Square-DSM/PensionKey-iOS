import Foundation
import Moya
import Core

public enum NoticeAPI {
    case createNotice(title: String, content: String)
    case fetchNoticeDetail(feedId: String)
    case deleteNotice(feedId: String)
    case fetchNoticeList
    case searchNoticeList(keyword: String)
    case searchKeyList
    case fetchMyNoticeList
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
        case .searchNoticeList:
            return "feeds/search"
        case .searchKeyList:
            return "feeds/search-key"
        case .fetchMyNoticeList:
            return "feeds"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .createNotice:
            return .post
        case .deleteNotice:
            return .delete
        case .fetchNoticeDetail, .fetchNoticeList, .searchNoticeList, .searchKeyList, .fetchMyNoticeList:
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
        case .searchNoticeList(let keyword):
            return .requestParameters(parameters: 
                                        [
                                            "keyword": keyword
                                        ], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
