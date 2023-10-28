import UIKit
public class UIPaddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

    public convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
