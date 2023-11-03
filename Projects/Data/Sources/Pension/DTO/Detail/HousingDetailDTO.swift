import Foundation
import Domain

struct HousingDetailDTO: Decodable {
    let paymentType: String
    let expectPension: Int
    let pensionEndDate, managementBranch: String

    enum CodingKeys: String, CodingKey {
        case paymentType = "payment_type"
        case expectPension = "expect_pension"
        case pensionEndDate = "pension_end_date"
        case managementBranch = "management_branch"
    }
}

extension HousingDetailDTO {
    func toDomain() -> HousingDetailEntity {
        return .init(
            paymentType: paymentType,
            expectPension: expectPension,
            pensionEndDate: pensionEndDate,
            managementBranch: managementBranch
        )
    }
}
