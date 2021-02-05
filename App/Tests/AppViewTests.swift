import Testing
import XCTest
@testable import App

final class AppViewTests: XCTestCase {
  func testPreviewSnapshot() {
    assertSnapshots(
      matching: AppView_Previews.previews,
      config: [
        .init("iPhoneXr", .device(config: .iPhoneXr), scale: 2),
        .init("iPhoneSe", .device(config: .iPhoneSe), scale: 2),
        .init("iPhoneX", .device(config: .iPhoneX), scale: 3)
      ]
    )
  }
}
