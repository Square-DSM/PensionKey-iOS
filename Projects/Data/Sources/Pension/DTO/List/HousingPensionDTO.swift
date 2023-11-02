import Foundation
import Domain

struct HousingPensionDTOElement: Decodable {
    let id, paymentType: String
    let expectPension: Int
    let pensionEndDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case paymentType = "payment_type"
        case expectPension = "expect_pension"
        case pensionEndDate = "pension_end_date"
    }
}

typealias HousingPensionDTO = [HousingPensionDTOElement]

extension HousingPensionDTO {
    func toDomain() -> HousingPensionEntity {
        return self.map { $0.toDomain() }
    }
}

extension HousingPensionDTOElement {
    func toDomain() -> HousingPensionEntityElement {
        return .init(
            id: id,
            paymentType: paymentType,
            expectPension: expectPension,
            pensionEndDate: pensionEndDate
        )
    }
}

