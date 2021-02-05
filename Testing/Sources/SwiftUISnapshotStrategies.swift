import SnapshotTesting
import SwiftUI

public func + <View: SwiftUI.View>(
  lhs: [String: Snapshotting<View, UIImage>],
  rhs: [String: Snapshotting<View, UIImage>]
) -> [String: Snapshotting<View, UIImage>] {
  lhs.merging(rhs) { $1 }
}

public extension Dictionary where Key == String {
  static func viewSnapshot<View: SwiftUI.View>(
    uiStyles: [UIUserInterfaceStyle] = [.light, .dark],
    scales: [CGFloat] = [1]
  ) -> Self where Value == Snapshotting<View, UIImage> {
    var result: Self = [:]
    uiStyles.forEach { uiStyle in
      scales.forEach { scale in
        result["\(uiStyle.name)-\(ScaleFormatter.string(for: scale))"] = .image(
          layout: .sizeThatFits,
          traits: .init(traitsFrom: [
            .init(userInterfaceStyle: uiStyle),
            .init(displayScale: scale)
          ])
        )
      }
    }
    return result
  }
}

public extension Dictionary where Key == String {
  static func iPhoneScreenshot<View: SwiftUI.View>(
    orientations: [ViewImageConfig.Orientation] = [.portrait],
    uiStyles: [UIUserInterfaceStyle] = [.light, .dark]
  ) -> Self where Value == Snapshotting<View, UIImage> {
    var result: Self = [:]
    orientations.forEach { orientation in
      uiStyles.forEach { uiStyle in
        let name = [orientation.name, uiStyle.name]
          .compactMap { $0 }
          .joined(separator: "-")

        result["iPhoneSe-\(name)"] = .image(
          layout: .device(config: .iPhoneSe(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPhone8-\(name)"] = .image(
          layout: .device(config: .iPhone8(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPhone8Plus-\(name)"] = .image(
          layout: .device(config: .iPhone8Plus(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 3),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPhoneX-\(name)"] = .image(
          layout: .device(config: .iPhoneX(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 3),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPhoneXsMax-\(name)"] = .image(
          layout: .device(config: .iPhoneXsMax(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 3),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPhoneXr-\(name)"] = .image(
          layout: .device(config: .iPhoneXr(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
      }
    }
    return result
  }
}

public extension Dictionary where Key == String {
  static func iPadScreenshot<View: SwiftUI.View>(
    orientations: [ViewImageConfig.TabletOrientation] = .all,
    uiStyles: [UIUserInterfaceStyle] = [.light, .dark]
  ) -> Self where Value == Snapshotting<View, UIImage> {
    var result: Self = [:]
    orientations.forEach { orientation in
      uiStyles.forEach { uiStyle in
        let name = [orientation.name, uiStyle.name].joined(separator: "-")

        result["iPadMini-\(name)"] = .image(
          layout: .device(config: .iPadMini(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPadMini-\(name)"] = .image(
          layout: .device(config: .iPadMini(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPadPro-10.5-\(name)"] = .image(
          layout: .device(config: .iPadPro10_5(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPadPro-11-\(name)"] = .image(
          layout: .device(config: .iPadPro11(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
        result["iPadPro-12.9-\(name)"] = .image(
          layout: .device(config: .iPadPro12_9(orientation)),
          traits: .init(traitsFrom: [
            .init(displayScale: 2),
            .init(userInterfaceStyle: uiStyle)
          ])
        )
      }
    }
    return result
  }
}

public extension Sequence where Element == ViewImageConfig.TabletOrientation {
  static var all: [Element] {
    [.landscape(splitView: .full),
     .landscape(splitView: .oneThird),
     .landscape(splitView: .oneHalf),
     .landscape(splitView: .twoThirds),
     .portrait(splitView: .full),
     .portrait(splitView: .oneThird),
     .portrait(splitView: .twoThirds)]
  }
}

private struct ScaleFormatter {
  static func string(for scale: CGFloat) -> String {
    "\(formatter.string(from: scale as NSNumber)!)x"
  }

  private static let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.decimalSeparator = "."
    formatter.usesGroupingSeparator = false
    return formatter
  }()
}

private extension ViewImageConfig.Orientation {
  var name: String? {
    switch self {
    case .portrait: return nil
    case .landscape: return "landscape"
    }
  }
}

private extension ViewImageConfig.TabletOrientation {
  var name: String {
    switch self {
    case let .landscape(split):
      return ["landscape", split.name].compactMap { $0 }.joined(separator: "-")
    case let .portrait(split):
      return ["portrait", split.name].compactMap { $0 }.joined(separator: "-")
    }
  }
}

private extension ViewImageConfig.TabletOrientation.LandscapeSplits {
  var name: String? {
    switch self {
    case .oneThird: return "split-one-third"
    case .oneHalf: return "split-one-half"
    case .twoThirds: return "split-two-thirds"
    case .full: return nil
    }
  }
}

private extension ViewImageConfig.TabletOrientation.PortraitSplits {
  var name: String? {
    switch self {
    case .oneThird: return "split-one-third"
    case .twoThirds: return "split-two-thirds"
    case .full: return nil
    }
  }
}

private extension UIUserInterfaceStyle {
  var name: String {
    switch self {
    case .light: return "light"
    case .dark: return "dark"
    case .unspecified: fatalError()
    @unknown default: fatalError()
    }
  }
}
