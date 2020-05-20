import Combine
import SwiftUI

public struct KeyboardHandler: ViewModifier {
    
    public enum Kind: Equatable {
        case offset
        case padding
    }
    
    private let kind: Kind
    
    public init(kind: Kind) {
        self.kind = kind
    }
    
    @State var currentHeight: CGFloat = 0
    
    public func body(content: Content) -> some View {
        content
            .transition(.slide)
            .offset(x: 0, y: kind == .offset ? -self.currentHeight : 0)
            .padding(.bottom, kind == .padding ? self.currentHeight : 0)
            .edgesIgnoringSafeArea(self.currentHeight == 0 ? Edge.Set() : .bottom)
            .onAppear(perform: subscribeToKeyboardEvents)
    }
    
    private let keyboardWillOpen = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height }
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }
    
    private func subscribeToKeyboardEvents() {
        _ = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.self.currentHeight, on: self)
    }
}

extension View {
    public func withKeyboardHandler(kind: KeyboardHandler.Kind) -> some View {
        self.modifier(KeyboardHandler(kind: kind))
    }
}
