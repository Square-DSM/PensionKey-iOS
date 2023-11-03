import UIKit

public extension Int {
    func toDecimal() -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        let result: String = numberFormatter.string(for: self)!
        return result
    }
}
