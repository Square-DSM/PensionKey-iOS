import Foundation
import Domain

struct PersonalPensionDTOElement: Decodable {
    let id, companyName, productName: String
    let totalPaymentAmt: Int

    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case productName = "product_name"
        case totalPaymentAmt = "total_payment_amt"
    }
}

typealias PersonalPensionDTO = [PersonalPensionDTOElement]

extension PersonalPensionDTO {
    func toDomain() -> PersonalPensionEntity {
        return self.map { $0.toDomain() }
    }
}

extension PersonalPensionDTOElement {
    func toDomain() -> PersonalPensionEntityElement {
        return .init(
            id: id,
            companyName: companyName,
            productName: productName,
            totalPaymentAmt: totalPaymentAmt
        )
    }
}
