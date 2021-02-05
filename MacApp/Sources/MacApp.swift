import Common
import SwiftUI

@main
struct MacApp: App {
  var body: some Scene {
    WindowGroup {
      if !isRunningTests && !isRunningPreviews {
        Text("Hello, world!")
          .frame(width: 640, height: 480)
      }
    }
  }
}
