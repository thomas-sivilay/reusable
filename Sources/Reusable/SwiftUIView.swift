import SwiftUI
import Combine

final class ObservableArray<T>: ObservableObject {
    
    @Published var array = [T].init()
    var cancellable: Set<AnyCancellable> = []
    
    init(array: [T]) {
        self.array = array
    }
    
    func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        let _array = array as! [T]
        _array.forEach {
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })
            self.cancellable.insert(c)
        }
        return self as! ObservableArray<T>
    }
}
