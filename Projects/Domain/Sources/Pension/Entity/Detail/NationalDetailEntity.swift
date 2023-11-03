import Foundation

public struct NationalDetailEntity {
    public let meanMonthlyIncome, expectTotalPay, payMonth: Int
    public let pensionPayDate: String

    public init(meanMonthlyIncome: Int, expectTotalPay: Int, payMonth: Int, pensionPayDate: String) {
        self.meanMonthlyIncome = meanMonthlyIncome
        self.expectTotalPay = expectTotalPay
        self.payMonth = payMonth
        self.pensionPayDate = pensionPayDate
    }
}
