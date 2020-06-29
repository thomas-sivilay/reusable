import SwiftUI

extension View {
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension View {
    public func fillParentWidth(alignment: Alignment = .center) -> some View {
        return GeometryReader { geometry in
            self.frame(width: geometry.size.width, height: nil, alignment: alignment)
        }
    }
}

#if canImport(UIKit)
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
