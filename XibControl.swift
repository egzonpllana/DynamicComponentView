//
//  Created by Egzon Pllana on 13/07/20.
//

import UIKit

private struct EncodingKey {
    static let nibName = "nibName"
}

@IBDesignable open class XibControl: UIControl {

    fileprivate var contentView: UIView?

    /*@IBInspectable*/ fileprivate var nibName: String? {
        didSet {
            xibSetup()
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibName = aDecoder.decodeObject(forKey: EncodingKey.nibName) as? String
        xibSetup()
    }

    public init(frame: CGRect, nibName: String) {
        super.init(frame: frame)
        self.nibName = nibName
        xibSetup()
    }

    public init?(coder aDecoder: NSCoder, nibName: String) {
        super.init(coder: aDecoder)
        self.nibName = nibName
        xibSetup()
    }

    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        contentView?.prepareForInterfaceBuilder()
    }

    override open func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(nibName, forKey: EncodingKey.nibName)
    }

    fileprivate func xibSetup() {
        contentView?.removeFromSuperview()
        contentView = nil
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }

    fileprivate func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }

}
