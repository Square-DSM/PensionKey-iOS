import Foundation
import Domain
import Core

struct SearchKeyDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case keyword
    }
    let keyword: String
}

typealias SearchKeyListDTO = [SearchKeyDTO]

extension SearchKeyListDTO {
    func toDomain() -> [SearchKeyEntity] {
        self.map {
            SearchKeyEntity(
                keyword: $0.keyword
            )
        }
    }
}
