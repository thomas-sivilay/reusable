import UIKit

public extension UICollectionView {
    typealias ReusableSupplementaryView = UICollectionReusableView & Reusable
    
    func registerReusableCell<T: Reusable>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
    
    func registerReusableSupplementaryView<T: ReusableSupplementaryView>(_: T.Type) {
        register(T.self, forSupplementaryViewOfKind: T.kindIdentifier, withReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: ReusableSupplementaryView>(for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: T.kindIdentifier, withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't dequeue supplementary view of kind :\(T.kindIdentifier) with reusable identifier: \(T.reusableIdentifier)")
        }
        return view
    }

    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
}
