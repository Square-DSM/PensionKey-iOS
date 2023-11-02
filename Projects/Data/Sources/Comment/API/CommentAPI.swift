import Foundation
import Moya
import Core

public enum CommentAPI {
    case fetchCommentList(feedId: String)
    case createComment(feedId: String, content: String)
}

extension CommentAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .fetchCommentList(let feedId), .createComment(let feedId, _):
            return "/comment/\(feedId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchCommentList:
            return .get
        case .createComment:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .createComment(_, let content):
            return .requestParameters(parameters:
                                        [
                                            "content": content
                                        ] , encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
