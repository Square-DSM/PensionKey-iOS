import Foundation
import Domain

struct PersonalDetailDTO: Decodable {
    let companyName, productName: String
    let totalPaymentAmt, expectPension: Int

    enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case productName = "product_name"
        case totalPaymentAmt = "total_payment_amt"
        case expectPension = "expect_pension"
    }
}

extension PersonalDetailDTO {
    func toDomain() -> PersonalDetailEntity {
        return .init(
            companyName: companyName,
            productName: productName,
            totalPaymentAmt: totalPaymentAmt,
            expectPension: expectPension
        )
    }
}
