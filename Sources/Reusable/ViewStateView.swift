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
    
    public var body: some View {
        switch viewState {
        case .loaded(let result):
            return content(result)
                .eraseToAnyView()
        case .loading:
            return ActivityIndicator(isAnimating: $isAnimating, style: .large).eraseToAnyView()
        case .error(let error):
            return errorView(error)
                .eraseToAnyView()
        case .empty:
            return emptyView()
                .eraseToAnyView()
        }
    }
}
