import UIKit

extension UIStackView {
    
    public func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addArrangedSubview($0)
        }
    }
    
    public static func VStack(spacing: CGFloat, alignment: Alignment) -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = spacing
        stackView.axis = .vertical
        stackView.alignment = alignment
        return stackView
    }
    
    public static func HStack(spacing: CGFloat, alignment: Alignment) -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = spacing
        stackView.axis = .horizontal
        stackView.alignment = alignment
        return stackView
    }
}
