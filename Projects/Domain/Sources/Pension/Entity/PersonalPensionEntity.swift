import Foundation

public struct PersonalPensionEntityElement {
    public let id, companyName, productName: String
    public let totalPaymentAmt: Int

    public init(id: String, companyName: String, productName: String, totalPaymentAmt: Int) {
        self.id = id
        self.companyName = companyName
        self.productName = productName
        self.totalPaymentAmt = totalPaymentAmt
    }
}

public typealias PersonalPensionEntity = [PersonalPensionEntityElement]
