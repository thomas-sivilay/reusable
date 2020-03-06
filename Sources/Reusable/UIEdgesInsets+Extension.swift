import UIKit

extension UIEdgeInsets {
    
    public init(all: CGFloat) {
        self.init()
        self.left = all
        self.right = all
        self.top = all
        self.bottom = all
    }
    
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init()
        self.left = horizontal
        self.right = horizontal
        self.top = vertical
        self.bottom = vertical
    }
    
    static func horizontal(_ value: CGFloat) -> Self {
        return UIEdgeInsets(horizontal: value, vertical: 0)
    }
    
    static func vertical(_ value: CGFloat) -> Self {
        return UIEdgeInsets(horizontal: 0, vertical: value)
    }
    
    static func all(_ value: CGFloat) -> Self {
        return UIEdgeInsets(all: value)
    }
}
