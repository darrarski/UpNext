import SnapshotTesting
import SwiftUI
import UIKit
import XCTest

public func assertSnapshots<Value: SwiftUI.View>(
  matching value: Value,
  drawHierarchyInKeyWindow: Bool = false,
  precision: Float = 1,
  config configs: [SwiftUISnapshotConfig] = [.init()],
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

  configs.forEach { config in
    config.uiStyles.forEach { uiStyle in
      SnapshotTesting.assertSnapshot(
        matching: value,
        as: .image(
          drawHierarchyInKeyWindow: drawHierarchyInKeyWindow,
          precision: precision,
          layout: config.layout,
          traits: .init(
            traitsFrom: [
              .init(userInterfaceStyle: uiStyle),
              config.displayScale.map(UITraitCollection.init(displayScale:)),
              config.traits
            ].compactMap { $0 }
          )
        ),
        named: [name, config.name, uiStyle.name]
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
}



public struct SwiftUISnapshotConfig {
  public init(
    _ name: String? = nil,
    _ layout: SwiftUISnapshotLayout = .sizeThatFits,
    scale displayScale: CGFloat? = nil,
    uiStyles: [UIUserInterfaceStyle] = [.light, .dark],
    traits: UITraitCollection? = nil
  ) {
    self.name = name
    self.layout = layout
    self.displayScale = displayScale
    self.uiStyles = uiStyles
    self.traits = traits
  }

  var name: String?
  var layout: SwiftUISnapshotLayout
  var displayScale: CGFloat?
  var uiStyles: [UIUserInterfaceStyle]
  var traits: UITraitCollection?
}

private extension UIUserInterfaceStyle {
  var name: String {
    switch self {
    case .dark: return "dark"
    case .light: return "light"
    case .unspecified: fatalError()
    @unknown default: fatalError()
    }
  }
}
