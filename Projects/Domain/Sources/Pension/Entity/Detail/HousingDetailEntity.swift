import Foundation

public struct HousingDetailEntityElement: Codable {
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

public typealias HousingDetailEntity = [HousingDetailEntityElement]

