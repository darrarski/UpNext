import Common
import ComposableArchitecture
import SwiftUI

@main
struct App: SwiftUI.App {
  let store = Store<AppState, AppAction>(
    initialState: AppState(),
    reducer: appReducer,
    environment: AppEnvironment()
  )

  var body: some Scene {
    WindowGroup {
      if !isRunningTests && !isRunningPreviews {
        AppView(store: store)
      }
    }
  }
}
