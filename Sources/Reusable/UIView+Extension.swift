import UIKit

extension UIView {

    public func addSubviews(_ subviews: [UIView], usingAutoLayout: Bool = true) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = !usingAutoLayout
            addSubview($0)
        }
    }
    
    public func addSubviews(_ subviews: UIView...) {
        addSubviews(subviews)
    }

}
