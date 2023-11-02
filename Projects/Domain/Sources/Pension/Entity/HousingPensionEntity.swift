import Foundation

public struct HousingPensionEntityElement {
    public let id, paymentType: String
    public let expectPension: Int
    public let pensionEndDate: String

    public init(id: String, paymentType: String, expectPension: Int, pensionEndDate: String) {
        self.id = id
        self.paymentType = paymentType
        self.expectPension = expectPension
        self.pensionEndDate = pensionEndDate
    }
}

public typealias HousingPensionEntity = [HousingPensionEntityElement]
