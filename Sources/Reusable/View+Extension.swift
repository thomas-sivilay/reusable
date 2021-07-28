import SwiftUI

extension View {
    public func eraseToAnyView() -> some View {
        AnyView(self)
    }
}

extension View {
    @ViewBuilder
    public func embeddedInScrollView(when condition: Bool) -> some View {
        if condition {
            ScrollView {
                self
            }
        } else {
            self
        }
    }
    
    @ViewBuilder
    public func overlayIf<Overlay: View>(_ condition: Bool, content: @escaping () -> Overlay) -> some View {
        ZStack {
            self
            if condition {
                content()
            }
        }
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
@available(iOSApplicationExtension, unavailable)
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    public func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach {
            $0.endEditing(force)
        }
    }
}
#endif
