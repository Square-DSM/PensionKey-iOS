import Foundation

public struct HousingDetailEntity: Codable {
    public let paymentType: String
    public let expectPension: Int
    public let pensionEndDate, managementBranch: String

    public init(paymentType: String, expectPension: Int, pensionEndDate: String, managementBranch: String) {
        self.paymentType = paymentType
        self.expectPension = expectPension
        self.pensionEndDate = pensionEndDate
        self.managementBranch = managementBranch
    }
}

