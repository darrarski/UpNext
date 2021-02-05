#if os(macOS)
import AppKit
import SnapshotTesting
import SwiftUI

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
