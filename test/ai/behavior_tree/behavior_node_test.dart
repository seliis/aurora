// ignore_for_file: avoid_print
import "package:aurora/ai/behavior_tree/behavior_status.dart";
import "package:aurora/ai/behavior_tree/behavior_node.dart";
import "package:flutter_test/flutter_test.dart";

class MockBehaviorNode extends BehaviorNode {
  // Constructor
  MockBehaviorNode({
    this.initialized      = 0,
    this.terminated       = 0,
    this.updated          = 0,
    this.returnedStatus   = BehaviorStatus.running,
    this.terminatedStatus = BehaviorStatus.invaild,
  });

  // Public
  @override
  void onInitialize() {
    ++initialized;
  }

  @override
  void onTerminate(BehaviorStatus behaviorStatus) {
    ++terminated;
    terminatedStatus = behaviorStatus;
  }

  @override
  BehaviorStatus update() {
    ++updated;
    return returnedStatus;
  }

  // Private
  int initialized;
  int terminated;
  int updated;

  BehaviorStatus returnedStatus;
  BehaviorStatus terminatedStatus;
}

void main() {
  test("Initialize", () {
    MockBehaviorNode mockBehaviorNode = MockBehaviorNode();
    expect(0, mockBehaviorNode.initialized);
    mockBehaviorNode.tick();
    expect(1, mockBehaviorNode.initialized);
  });
  test("Update", () {
    MockBehaviorNode mockBehaviorNode = MockBehaviorNode();
    expect(0, mockBehaviorNode.updated);
    mockBehaviorNode.tick();
    expect(1, mockBehaviorNode.updated);
  });
  test("Terminate", () {
    MockBehaviorNode mockBehaviorNode = MockBehaviorNode();
    mockBehaviorNode.tick();
    expect(0, mockBehaviorNode.terminated);
    mockBehaviorNode.returnedStatus = BehaviorStatus.success;
    mockBehaviorNode.tick();
    expect(1, mockBehaviorNode.terminated);
  });
}