import Foundation

open class Preferences {
    
    fileprivate let store = NSUbiquitousKeyValueStore.default
    
    public static let `default` = Preferences()
    
    private init() { }
    
    public func configure() {
        NotificationCenter.default.addObserver(self, selector: #selector(storeDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: store)
        synchronize()
    }
    
    public func synchronize() {
        store.synchronize()
    }
        
    @objc
    private func storeDidChange(notification: NSNotification) {
        // TODO
    }
}

public protocol PreferenceKey {
    var value: String { get }
}

@propertyWrapper
public struct UbiquitousKeyValue<T> {
    public let key: PreferenceKey
    public let defaultValue: T
    
    public init(_ key: PreferenceKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            Preferences.default.store.object(forKey: key.value) as? T ?? defaultValue
        }
        set {
            Preferences.default.store.set(newValue, forKey: key.value)
            Preferences.default.synchronize()
        }
    }
}
