import Foundation

open class Preferences {
    
    public let store: NSUbiquitousKeyValueStore
    
    public init(store: NSUbiquitousKeyValueStore) {
        self.store = store
    }
    
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
    let key: PreferenceKey
    let defaultValue: T
    let store: NSUbiquitousKeyValueStore
    
    public init(_ key: PreferenceKey, defaultValue: T, store: NSUbiquitousKeyValueStore) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }
    
    public var wrappedValue: T {
        get {
            return store.object(forKey: key.value) as? T ?? defaultValue
        }
        set {
            store.set(newValue, forKey: key.value)
            store.synchronize()
        }
    }
}
