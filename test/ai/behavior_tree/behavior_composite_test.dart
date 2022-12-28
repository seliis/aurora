// ignore_for_file: avoid_print

import "package:aurora/ai/behavior_tree/behavior_composite.dart";
import "package:flutter_test/flutter_test.dart";

class MockComposite extends BehaviorComposite {
  // Constructor

  // Private
}

void main() {
  test("Composite", () {
    MockComposite mockComposite = MockComposite();
    print(mockComposite.behaviorNodeList.length);
  });
}