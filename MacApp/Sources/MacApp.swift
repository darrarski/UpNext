import Common
import SwiftUI

@main
struct MacApp: App {
  var body: some Scene {
    WindowGroup {
      if !isRunningTests && !isRunningPreviews {
        MacAppView()
      }
    }
  }
}
