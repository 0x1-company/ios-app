import BeMatch
import BeMatchClient
import ComposableArchitecture
import FeedbackGeneratorClient
import MatchNavigationFeature
import RecommendationFeature
import SwiftUI
import UserNotificationClient

@Reducer
public struct RootNavigationLogic {
  public init() {}

  @CasePathable
  public enum Tab {
    case swipe
    case match
  }

  public struct State: Equatable {
    var recommendation = RecommendationLogic.State()
    var match = MatchNavigationLogic.State()

    @BindingState var tab = Tab.swipe

    public init() {}
  }

  public enum Action: BindableAction {
    case onTask
    case recommendation(RecommendationLogic.Action)
    case match(MatchNavigationLogic.Action)
    case binding(BindingAction<State>)
    case pushNotificationBadgeResponse(Result<BeMatch.PushNotificationBadgeQuery.Data, Error>)
  }

  @Dependency(\.mainQueue) var mainQueue
  @Dependency(\.feedbackGenerator) var feedbackGenerator
  @Dependency(\.userNotifications.setBadgeCount) var setBadgeCount
  @Dependency(\.bematch.pushNotificationBadge) var pushNotificationBadge

  enum Cancel {
    case pushNotificationBadge
  }

  public var body: some Reducer<State, Action> {
    BindingReducer()
    Scope(state: \.recommendation, action: \.recommendation) {
      RecommendationLogic()
    }
    Scope(state: \.match, action: \.match) {
      MatchNavigationLogic()
    }
    Reduce<State, Action> { state, action in
      switch action {
      case .onTask:
        return .run { send in
          await withTaskGroup(of: Void.self) { group in
            group.addTask {
              await pushNotificationBadgeRequest(send: send)
            }
          }
        }

      case .match(.match(.empty(.delegate(.toRecommendation)))):
        state.tab = .swipe
        return .none

      case .binding(\.$tab):
        return .run { _ in
          await feedbackGenerator.impactOccurred()
        }

      case let .pushNotificationBadgeResponse(.success(data)):
        return .run { _ in
          try? await setBadgeCount(data.pushNotificationBadge.count)
        }

      default:
        return .none
      }
    }
  }

  func pushNotificationBadgeRequest(send: Send<Action>) async {
    await withTaskCancellation(id: Cancel.pushNotificationBadge) {
      do {
        for try await data in pushNotificationBadge() {
          await send(.pushNotificationBadgeResponse(.success(data)))
        }
      } catch {
        await send(.pushNotificationBadgeResponse(.failure(error)))
      }
    }
  }
}

public struct RootNavigationView: View {
  let store: StoreOf<RootNavigationLogic>

  public init(store: StoreOf<RootNavigationLogic>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      TabView(selection: viewStore.$tab) {
        NavigationStack {
          RecommendationView(store: store.scope(state: \.recommendation, action: \.recommendation))
        }
        .tag(RootNavigationLogic.Tab.swipe)
        .tabItem {
          Image(
            viewStore.tab.is(\.swipe)
              ? ImageResource.searchActive
              : ImageResource.searchDeactive
          )
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 30, height: 30)
        }

        MatchNavigationView(store: store.scope(state: \.match, action: \.match))
          .tag(RootNavigationLogic.Tab.match)
          .tabItem {
            Image(
              viewStore.tab.is(\.match)
                ? ImageResource.starActive
                : ImageResource.starDeactive
            )
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
          }
      }
      .task { await store.send(.onTask).finish() }
    }
  }
}

#Preview {
  RootNavigationView(
    store: .init(
      initialState: RootNavigationLogic.State(),
      reducer: { RootNavigationLogic() }
    )
  )
  .environment(\.colorScheme, .dark)
}
