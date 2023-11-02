import Foundation
import Moya
import Core

public enum PensionAPI {
    case fetchNationalPensionList
    case fetchHousingPensionList
    case fetchPersonalPensionList

    case fetchNationalPensionDetailList
    case fetchHousingPensionDetailList(id: String)
    case fetchPersonalPensionDetailList(id: String)
}

extension PensionAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .fetchNationalPensionList:
            return "/money/pension"
        case .fetchHousingPensionList:
            return "/money/house"
        case .fetchPersonalPensionList:
            return "/money/individual"
        case .fetchNationalPensionDetailList:
            return "/money/detail"
        case .fetchHousingPensionDetailList(let id):
            return "/money/house/\(id)"
        case .fetchPersonalPensionDetailList(let id):
            return "/money/individual/\(id)"
        }
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
