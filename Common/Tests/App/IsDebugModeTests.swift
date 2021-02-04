import XCTest
@testable import Common

final class IsDebugModeTests: XCTestCase {
  func testShouldBeRunningInDebugMode() {
    XCTAssertTrue(isDebugMode)
  }
}
