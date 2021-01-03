import SwiftUI

public struct DelayedAppearingView<Content: View>: View {
    @State var didAppear: Bool = false
    
    let content: () -> Content
    private let delay: Double
    
    public init(
        delay: Double,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.delay = delay
        self.content = content
    }
    
    @ViewBuilder public var body: some View {
        Group {
            content()
                .opacity(didAppear ? 1 : 0)
                .animation(Animation.easeInOut.delay(delay))
        }
        .onAppear {
            withAnimation {
                didAppear = true
            }
        }
    }
}
