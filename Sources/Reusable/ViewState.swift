import Foundation

enum ViewState<T, E: Error> {
    case loading
    case loaded(T)
    case empty
    case error(E)
    
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }
    
    var result: T? {
        switch self {
        case .loaded(let t): return t
        default: return nil
        }
    }
    
    var error: E? {
        switch self {
        case .error(let e): return e
        default: return nil
        }
    }
}