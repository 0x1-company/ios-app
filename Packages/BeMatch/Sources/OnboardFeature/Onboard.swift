import BeMatch
import BeRealCaptureFeature
import BeRealSampleFeature
import ComposableArchitecture
import FirebaseAuth
import GenderSettingFeature
import SwiftUI
import UserDefaultsClient
import UsernameSettingFeature

@Reducer
public struct OnboardLogic {
  public init() {}

  public struct State: Equatable {
    let user: BeMatch.UserInternal?
    var username: UsernameSettingLogic.State
    var path = StackState<Path.State>()

    public init(user: BeMatch.UserInternal?) {
      self.user = user
      username = UsernameSettingLogic.State(username: user?.berealUsername ?? "")
    }
  }

  public enum Action {
    case onTask
    case username(UsernameSettingLogic.Action)
    case path(StackAction<Path.State, Path.Action>)
  }

  @Dependency(\.userDefaults) var userDefaults

  public var body: some Reducer<State, Action> {
    Scope(state: \.username, action: \.username) {
      UsernameSettingLogic()
    }
    Reduce<State, Action> { state, action in
      switch action {
      case .username(.delegate(.nextScreen)):
        let gender = state.user?.gender.value
        state.path.append(.gender(GenderSettingLogic.State(gender: gender == .other ? nil : gender)))
        return .none

      case .path(.element(_, .gender(.delegate(.nextScreen)))):
        state.path.append(.sample())
        return .none

      case .path(.element(_, .sample(.delegate(.nextScreen)))):
        state.path.append(.capture())
        return .none

      default:
        return .none
      }
    }
    .forEach(\.path, action: \.path) {
      Path()
    }
  }

  @Reducer
  public struct Path {
    public enum State: Equatable {
      case gender(GenderSettingLogic.State)
      case sample(BeRealSampleLogic.State = .init())
      case capture(BeRealCaptureLogic.State = .init())
    }

    public enum Action {
      case gender(GenderSettingLogic.Action)
      case sample(BeRealSampleLogic.Action)
      case capture(BeRealCaptureLogic.Action)
    }

    public var body: some Reducer<State, Action> {
      Scope(state: \.gender, action: \.gender, child: GenderSettingLogic.init)
      Scope(state: \.sample, action: \.sample, child: BeRealSampleLogic.init)
      Scope(state: \.capture, action: \.capture, child: BeRealCaptureLogic.init)
    }
  }
}

public struct OnboardView: View {
  let store: StoreOf<OnboardLogic>

  public init(store: StoreOf<OnboardLogic>) {
    self.store = store
  }

  public var body: some View {
    NavigationStackStore(store.scope(state: \.path, action: \.path)) {
      UsernameSettingView(store: store.scope(state: \.username, action: \.username))
    } destination: { store in
      switch store {
      case .gender:
        CaseLet(
          /OnboardLogic.Path.State.gender,
          action: OnboardLogic.Path.Action.gender,
          then: GenderSettingView.init(store:)
        )
      case .sample:
        CaseLet(
          /OnboardLogic.Path.State.sample,
          action: OnboardLogic.Path.Action.sample,
          then: BeRealSampleView.init(store:)
        )
      case .capture:
        CaseLet(
          /OnboardLogic.Path.State.capture,
          action: OnboardLogic.Path.Action.capture,
          then: BeRealCaptureView.init(store:)
        )
      }
    }
    .tint(Color.white)
  }
}
