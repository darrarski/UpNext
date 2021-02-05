#if os(iOS)
import SnapshotTesting
import SwiftUI
import UIKit
import XCTest

public func assertSnapshots<View: SwiftUI.View>(
  matching value: View,
  as strategies: [String: Snapshotting<View, UIImage>],
  named name: String? = nil,
  record recording: Bool = false,
  file: StaticString = #file,
  testName: String = #function,
  line: UInt = #line
) {
  guard UIApplication.shared.windows.first?.safeAreaInsets.bottom == .zero
  else {
    XCTFail(
      ["SwiftUI snapshot tests must be run on a simulator of a device ",
       "without a notch. For example: iPhone 8 or iPhone SE ",
       "(1st and 2nd generation) simulators."]
        .joined(),
      file: file,
      line: line
    )
    return
  }

  let namedStrategies = strategies.reduce(into: [:]) { result, strategy in
    result[[name, strategy.key].compactMap { $0 }.joined(separator: "-")] = strategy.value
  }

  SnapshotTesting.assertSnapshots(
    matching: value,
    as: namedStrategies,
    record: recording,
    file: file,
    testName: testName,
    line: line
  )
}

#endif
