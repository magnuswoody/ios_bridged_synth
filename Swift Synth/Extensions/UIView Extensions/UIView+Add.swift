
import UIKit

extension UIView {
    public func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
