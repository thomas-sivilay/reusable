import UIKit

public extension UITableView {
    func registerReusableCell<T: Reusable>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reusableIdentifier)
    }

    func registerReusableHeaderFooter<T: Reusable>(_: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reusableIdentifier)
    }

    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: Reusable>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reusableIdentifier) as? T else {
            fatalError("Could not dequeue header footer view with identifier: \(T.reusableIdentifier)")
        }
        return headerFooterView
    }
}
