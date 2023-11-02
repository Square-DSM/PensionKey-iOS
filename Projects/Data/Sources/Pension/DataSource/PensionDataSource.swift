import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger

class PensionDataSource {

    private let provider = MoyaProvider<PensionAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = PensionDataSource()
    private init() {}
    
}
