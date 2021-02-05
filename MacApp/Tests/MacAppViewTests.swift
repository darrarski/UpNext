import Testing
import XCTest
@testable import MacApp

final class MacAppViewTests: XCTestCase {
  func testPreviewSnapshot() throws {
    assertSnapshots(matching: MacAppView_Previews.previews)
  }
}
