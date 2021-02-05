import ComposableArchitecture
import SwiftUI

struct AppView: View {
  let store: Store<AppState, AppAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      Text("Hello, world!")
    }
  }
}


struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: Store(
      initialState: AppState(),
      reducer: .empty,
      environment: ()
    ))
  }
}
