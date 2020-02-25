import Foundation

public enum ViewState<T, E: Error> {
    case loading(String)
    case loaded(T)
    case empty
    case error(E)
    
    public var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    public var result: T? {
        switch self {
        case .loaded(let t): return t
        default: return nil
        }
    }
    
    public var error: E? {
        switch self {
        case .error(let e): return e
        default: return nil
        }
    }
}
