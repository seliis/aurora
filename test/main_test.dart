// ignore_for_file: avoid_print

import 'dart:math';

import "package:flutter_test/flutter_test.dart";
import "package:aurora/ai/behavior_tree.dart";

class TestBehavior extends Behavior {
  int initialized;
  int terminated;
  int updated;

  BehaviorStatus returnedStatus;
  BehaviorStatus terminatedStatus;

  TestBehavior({
    this.initialized = 0,
    this.terminated = 0,
    this.updated = 0,
    this.returnedStatus = BehaviorStatus.running,
    this.terminatedStatus = BehaviorStatus.invalid,
  });

  @override
  void onInitialize() {
    ++initialized;
  }

  @override
  void onTerminate(BehaviorStatus behaviorStatus) {
    terminatedStatus = behaviorStatus;
    ++terminated;
  }

  @override
  BehaviorStatus update() {
    ++updated;
    return returnedStatus;
  }
}

class TestSequence extends Sequence {
  TestSequence(int size) {
    for (int i = 0; i < size; i++) {
      behaviorList.add(Behavior());
    }
  }
}

void main() async {
  test("Behavior: Initialize", () {
    TestBehavior testBehavior = TestBehavior();
    expect(0, testBehavior.initialized);

    testBehavior.tick();
    expect(1, testBehavior.initialized);
  });

  test("Behavior: Update", () {
    TestBehavior testBehavior = TestBehavior();
    expect(0, testBehavior.updated);

    testBehavior.tick();
    expect(1, testBehavior.updated);
  });

  test("Behavior: Terminate", () {
    TestBehavior testBehavior = TestBehavior();
    expect(0, testBehavior.terminated);

    testBehavior.returnedStatus = BehaviorStatus.success;

    testBehavior.tick();
    expect(1, testBehavior.terminated);
  });

  test("Composite: Sequence, Two Child Fails", () {
    TestSequence testSequence = TestSequence(2);
    expect(testSequence.tick(), BehaviorStatus.running);
    // expect(0, testSequence.behaviorList[0].abort());
  });
}
