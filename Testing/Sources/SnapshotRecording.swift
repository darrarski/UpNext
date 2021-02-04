import SnapshotTesting

public var isRecording: Bool {
  get { SnapshotTesting.isRecording }
  set { SnapshotTesting.isRecording = newValue }
}
