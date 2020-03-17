import UIKit

public protocol Reusable: AnyObject {
    static var reusableIdentifier: String { get }
}

extension Reusable {
    public static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UICollectionReusableView {
    public static var kindIdentifier: String {
        return String(describing: self)
    }
}
