import Foundation

public struct NationalPensionEntityElement {
    public let id: String
    public let expectTotalPay, payMonth: Int

    public init(id: String, expectTotalPay: Int, payMonth: Int) {
        self.id = id
        self.expectTotalPay = expectTotalPay
        self.payMonth = payMonth
    }
}

public typealias NationalPensionEntity = [NationalPensionEntityElement]
