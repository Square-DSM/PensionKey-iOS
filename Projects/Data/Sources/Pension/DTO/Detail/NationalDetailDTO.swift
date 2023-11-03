import Foundation
import Domain

struct NationalDetailDTO: Decodable {
    let meanMonthlyIncome, expectTotalPay, payMonth: Int
    let pensionPayDate: String

    enum CodingKeys: String, CodingKey {
        case meanMonthlyIncome = "mean_monthly_income"
        case expectTotalPay = "expect_total_pay"
        case payMonth = "pay_month"
        case pensionPayDate = "pension_pay_date"
    }
}

extension NationalDetailDTO {
    func toDomain() -> NationalDetailEntity {
        return .init(
            meanMonthlyIncome: meanMonthlyIncome,
            expectTotalPay: expectTotalPay,
            payMonth: payMonth,
            pensionPayDate: pensionPayDate
        )
    }
}
