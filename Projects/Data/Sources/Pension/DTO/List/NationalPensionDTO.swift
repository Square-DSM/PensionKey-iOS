import Foundation
import Domain

struct NationalPensionDTOElement: Decodable {
    let id: String
    let expectTotalPay, payMonth: Int

    enum CodingKeys: String, CodingKey {
        case id
        case expectTotalPay = "expect_total_pay"
        case payMonth = "pay_month"
    }
}

typealias NationalPensionDTO = [NationalPensionDTOElement]

extension NationalPensionDTO {
    func toDomain() -> NationalPensionEntity {
        return self.map { $0.toDomain() }
    }
}

extension NationalPensionDTOElement {
    func toDomain() -> NationalPensionEntityElement {
        return .init(
                id: id,
                expectTotalPay: expectTotalPay,
                payMonth: payMonth
            )
    }
}
