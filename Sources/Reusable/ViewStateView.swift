import SwiftUI

public struct ViewStateView<Content: View, EmptyView: View, ErrorView: View, E: Error, T>: View {
    
    @State var isAnimating: Bool = true
    let content: (T) -> Content
    let emptyView: () -> EmptyView
    let errorView: (E) -> ErrorView
    let viewState: ViewState<T, E>
    
    public init(viewState: ViewState<T, E>,
                @ViewBuilder content: @escaping (T) -> Content,
                @ViewBuilder emptyView: @escaping () -> EmptyView,
                @ViewBuilder errorView: @escaping (E) -> ErrorView) {
        self.content = content
        self.viewState = viewState
        self.errorView = errorView
        self.emptyView = emptyView
    }
    
    @ViewBuilder public var body: some View {
        switch viewState {
        case .loaded(let result):
            content(result)
        case .loading(let message):
            VStack {
                ActivityIndicator(isAnimating: $isAnimating, style: .large)
                Text(message)
            }
        case .error(let error):
            errorView(error)
        case .empty:
            emptyView()
        }
    }
}
