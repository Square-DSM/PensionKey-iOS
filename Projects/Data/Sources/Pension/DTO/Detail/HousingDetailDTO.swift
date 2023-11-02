import Foundation
import Domain

struct HousingDetailDTOElement: Codable {
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

typealias HousingDetailDTO = [HousingDetailDTOElement]

extension HousingDetailDTO {
    func toDomain() -> HousingDetailEntity {
        return self.map { $0.toDomain() }
    }
}

extension HousingDetailDTOElement {
    func toDomain() -> HousingDetailEntityElement {
        return .init(
            id: id,
            paymentType: paymentType,
            expectPension: expectPension,
            pensionEndDate: pensionEndDate
        )
    }
}
