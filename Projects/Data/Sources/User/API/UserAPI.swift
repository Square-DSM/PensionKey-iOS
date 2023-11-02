import Foundation
import Moya
import Core

public enum UserAPI {
    case fetchUserInfo
}

extension UserAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        return "/users"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Moya.Task {
        return .requestPlain
    }

    public var headers: [String: String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
