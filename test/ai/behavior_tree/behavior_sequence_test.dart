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

  MockBehaviorNode operator [](int index) {
    List<MockBehaviorNode> castedList = behaviorNodeList.cast<MockBehaviorNode>();
    return castedList[index];
  }
}

void main() {
  test("TwoChildFails", () {
    MockSequence mockSequence = MockSequence(2);
    expect(mockSequence.tick(), BehaviorStatus.running);
    expect(0, mockSequence[0].terminated);
    mockSequence[0].returnedStatus = BehaviorStatus.failure;
    expect(mockSequence.tick(), BehaviorStatus.failure);
    expect(1, mockSequence[0].terminated);
    expect(0, mockSequence[1].initialized);
  });
  test("TwoChildContinue", () {
    MockSequence mockSequence = MockSequence(2);
    expect(mockSequence.tick(), BehaviorStatus.running);
    expect(0, mockSequence[0].terminated);
    expect(0, mockSequence[1].initialized);
    mockSequence[0].returnedStatus = BehaviorStatus.success;
    expect(mockSequence.tick(), BehaviorStatus.running);
    expect(1, mockSequence[0].terminated);
    expect(1, mockSequence[1].initialized);
  });
  test("OneChildPassThrough", () {
    List<BehaviorStatus> behaviorStatuses = <BehaviorStatus>[
      BehaviorStatus.success,
      BehaviorStatus.failure
    ];
    for (int i = 0; i < behaviorStatuses.length; ++i) {
      MockSequence mockSequence = MockSequence(1);
      expect(mockSequence.tick(), BehaviorStatus.running);
      expect(0, mockSequence[0].terminated);
      mockSequence[0].returnedStatus = behaviorStatuses[i];
      expect(mockSequence.tick(), behaviorStatuses[i]);
      expect(1, mockSequence[0].terminated);
    }
  });
}
