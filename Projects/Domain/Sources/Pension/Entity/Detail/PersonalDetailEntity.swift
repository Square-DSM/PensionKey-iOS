import Foundation

public struct PersonalDetailEntity {
    public let companyName, productName: String
    public let totalPaymentAmt, expectPension: Int

    public init(companyName: String, productName: String, totalPaymentAmt: Int, expectPension: Int) {
        self.companyName = companyName
        self.productName = productName
        self.totalPaymentAmt = totalPaymentAmt
        self.expectPension = expectPension
    }
}
