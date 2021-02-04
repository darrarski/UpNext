import XCTest
@testable import Common

final class IsRunningPreviewsTests: XCTestCase {
  func testShouldNotBeRunningPreviews() {
    XCTAssertFalse(isRunningPreviews)
  }
}
