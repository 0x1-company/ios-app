import AnalyticsClient
import BeMatch
import BeMatchClient
import ComposableArchitecture
import MatchedFeature
import SwiftUI
import SwipeCardFeature
import SwipeFeature

@Reducer
public struct ReceivedLikeSwipeLogic {
  public init() {}

  public struct State: Equatable {
    var swipe: SwipeLogic.State?

    public init() {}
  }

  public enum Action {
    case onTask
    case closeButtonTapped
    case usersByLikerResponse(Result<BeMatch.UsersByLikerQuery.Data, Error>)
    case swipe(SwipeLogic.Action)
    case delegate(Delegate)

    public enum Delegate: Equatable {
      case dismiss
    }
  }

  @Dependency(\.analytics) var analytics
  @Dependency(\.bematch.usersByLiker) var usersByLiker

  enum Cancel: Hashable {
    case usersByLiker
  }

  public var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      switch action {
      case .onTask:
        analytics.logScreen(screenName: "ReceivedLikeSwipe", of: self)
        return .run { send in
          for try await data in usersByLiker() {
            await send(.usersByLikerResponse(.success(data)))
          }
        } catch: { error, send in
          await send(.usersByLikerResponse(.failure(error)))
        }

      case .closeButtonTapped:
        return .send(.delegate(.dismiss))

      case let .usersByLikerResponse(.success(data)):
        let rows = data.usersByLiker
          .map(\.fragments.swipeCard)
          .filter { !$0.images.isEmpty }

        state.swipe = SwipeLogic.State(rows: rows)
        return .none

      case .usersByLikerResponse(.failure):
        return .send(.delegate(.dismiss))

      default:
        return .none
      }
    }
    .ifLet(\.swipe, action: \.swipe) {
      SwipeLogic()
    }
  }
}

public struct ReceivedLikeSwipeView: View {
  let store: StoreOf<ReceivedLikeSwipeLogic>

  public init(store: StoreOf<ReceivedLikeSwipeLogic>) {
    self.store = store
  }

  public var body: some View {
    IfLetStore(
      store.scope(state: \.swipe, action: \.swipe),
      then: SwipeView.init(store:)
    ) {
      Color.black
        .overlay {
          ProgressView()
            .tint(Color.white)
        }
    }
    .navigationTitle(String(localized: "People who Liked you", bundle: .module))
    .navigationBarTitleDisplayMode(.inline)
    .task { await store.send(.onTask).finish() }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          store.send(.closeButtonTapped)
        } label: {
          Image(systemName: "chevron.down")
            .bold()
            .foregroundStyle(Color.white)
            .frame(width: 44, height: 44)
        }
      }
    }
  }
}

#Preview {
  ReceivedLikeSwipeView(
    store: .init(
      initialState: ReceivedLikeSwipeLogic.State(),
      reducer: { ReceivedLikeSwipeLogic() }
    )
  )
}
