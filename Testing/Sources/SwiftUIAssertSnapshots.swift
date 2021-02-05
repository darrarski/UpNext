import SnapshotTesting
import SwiftUI

#if os(iOS)
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

#elseif os(macOS)
import AppKit

public func assertSnapshots<View: SwiftUI.View>(
  matching view: View,
  colorSchemes: [ColorScheme] = [.light, .dark],
  named name: String? = nil,
  record recording: Bool = false,
  file: StaticString = #file,
  testName: String = #function,
  line: UInt = #line
) {
  colorSchemes.forEach { colorScheme in
    let hostingController = NSHostingController(
      rootView: view
        .background(Color(.windowBackgroundColor))
        .environment(\.colorScheme, colorScheme)
    )
    let size = hostingController.sizeThatFits(in: .zero)

    SnapshotTesting.assertSnapshot(
      matching: hostingController,
      as: .image(size: size),
      named: [name, colorScheme.name]
        .compactMap { $0 }
        .filter { !$0.isEmpty }
        .joined(separator: "-"),
      record: recording,
      file: file,
      testName: testName,
      line: line
    )
  }
}

private extension ColorScheme {
  var name: String {
    switch self {
    case .light: return "light"
    case .dark: return "dark"
    @unknown default: fatalError()
    }
  }
}

#endif
