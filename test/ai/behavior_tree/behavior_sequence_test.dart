// ignore_for_file: avoid_print
import "package:aurora/ai/behavior_tree/behavior_sequence.dart";
import "package:aurora/ai/behavior_tree/behavior_status.dart";
import "package:flutter_test/flutter_test.dart";
import "behavior_node_test.dart";

class MockSequence extends BehaviorSequence {
  MockSequence(int size) {
    for (int i = 0; i < size; i++) {
      behaviorNodeList.add(MockBehaviorNode());
    }
  }
}

void main() {
  test("TwoFails", () {
    MockSequence mockSequence = MockSequence(2);
    expect(mockSequence.tick(), BehaviorStatus.running);
    // expect(0, mockSequence.behaviorNodeList[0].);
  });
}
