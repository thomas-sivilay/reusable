import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension View {
    func fillParentWidth(alignment: Alignment = .center) -> some View {
        return GeometryReader { geometry in
            self.frame(width: geometry.size.width, height: nil, alignment: alignment)
        }
    }
}
