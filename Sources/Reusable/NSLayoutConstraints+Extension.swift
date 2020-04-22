import UIKit

extension UIView {
    
    public enum LayoutGuide {
        case none
        case readableContent
        case layoutMargins
        case safeArea
        
        public func layoutGuide(for view: UIView) -> UILayoutGuide? {
            switch self {
            case .layoutMargins: return view.layoutMarginsGuide
            case .readableContent: return view.readableContentGuide
            case .safeArea: return view.safeAreaLayoutGuide
            case .none: return nil
            }
        }
    }
    
    public func addConstrainedSubview(_ view: UIView,
                                      using layoutGuide: LayoutGuide = .none,
                                      with edgeInsets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        if let layoutGuide = layoutGuide.layoutGuide(for: self) {
            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: edgeInsets.left),
                view.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -edgeInsets.right),
                view.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: edgeInsets.top),
                view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -edgeInsets.bottom),
            ])
        } else {
            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: leftAnchor, constant: edgeInsets.left),
                view.rightAnchor.constraint(equalTo: rightAnchor, constant: -edgeInsets.right),
                view.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeInsets.bottom),
            ])
        }
    }
}
