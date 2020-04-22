import Foundation

public extension CustomDebugStringConvertible {
    var debugDescription: String {
        let className = type(of: self)
        let address = "\(Unmanaged.passUnretained(self as AnyObject).toOpaque())"
        var description = "<\(className): \(address), {"
        let mirror = Mirror(reflecting: self)
        description += mirror.children.compactMap { (arg) -> String? in
            let (label, value) = arg
            guard let propertyName = label else { return nil }
            return "\(propertyName): \(value)"
        }.joined(separator: ", ")
        description += "}>"
        return description
    }
}
