import SwiftUI

public struct VisualEffectView: UIViewRepresentable {
    
    public var style: UIBlurEffect.Style

    public init(style: UIBlurEffect.Style) {
        self.style = style
    }

    public func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
