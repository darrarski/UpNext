import Testing
import XCTest
@testable import App

final class AppViewTests: XCTestCase {
  func testPreviewSnapshot() {
    assertSnapshots(
      matching: AppView_Previews.previews,
      as: .iPhoneScreenshot()
    )
  }
}
