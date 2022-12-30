// ignore_for_file: avoid_print
import "package:aurora/ai/behavior_tree/behavior_selector.dart";
import "package:aurora/ai/behavior_tree/behavior_status.dart";
import "package:flutter_test/flutter_test.dart";
import "behavior_node_test.dart";

class MockSelector extends BehaviorSelector {
  MockSelector(int size) {
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
  test("TwoChildContinues", () {
    MockSelector mockSelector = MockSelector(2);
    expect(mockSelector.tick(), BehaviorStatus.running);
    expect(0, mockSelector[0].terminated);
    mockSelector[0].returnedStatus = BehaviorStatus.failure;
    expect(mockSelector.tick(), BehaviorStatus.running);
    expect(1, mockSelector[0].terminated);
  });
  test("TwoChildSucceeds", () {
    MockSelector mockSelector = MockSelector(2);
    expect(mockSelector.tick(), BehaviorStatus.running);
    expect(0, mockSelector[0].terminated);
    mockSelector[0].returnedStatus = BehaviorStatus.success;
    expect(mockSelector.tick(), BehaviorStatus.success);
    expect(1, mockSelector[0].terminated);
  });
  test("OneChildPassThrough", () {
    List<BehaviorStatus> behaviorStatuses = <BehaviorStatus>[
      BehaviorStatus.success,
      BehaviorStatus.failure
    ];
    for (int i = 0; i < behaviorStatuses.length; ++i) {
      MockSelector mockSelector = MockSelector(1);
      expect(mockSelector.tick(), BehaviorStatus.running);
      expect(0, mockSelector[0].terminated);
      mockSelector[0].returnedStatus = behaviorStatuses[i];
      expect(mockSelector.tick(), behaviorStatuses[i]);
      expect(1, mockSelector[0].terminated);
    }
  });
}