import "package:aurora/ai/behavior_tree/behavior_status.dart";

abstract class BehaviorNodeAbstract {
  // Public
  BehaviorStatus update();
  BehaviorStatus tick();

  void reset();
  void abort();

  bool isTerminated();
  bool isRunning();

  BehaviorStatus getBehaviorStatus();

  void onInitialize();
  void onTerminate(BehaviorStatus behaviorStatus);

  // Private
  BehaviorStatus behaviorStatus = BehaviorStatus.invaild;
}

class BehaviorNode extends BehaviorNodeAbstract {
  @override
  BehaviorStatus update() {
    return BehaviorStatus.invaild;
  }

  @override
  BehaviorStatus tick() {
    if (behaviorStatus != BehaviorStatus.running) {
      onInitialize();
    }
    behaviorStatus = update();
    if (behaviorStatus != BehaviorStatus.running) {
      onTerminate(behaviorStatus);
    }
    return behaviorStatus;
  }

  @override
  void reset() {
    behaviorStatus = BehaviorStatus.invaild;
  }

  @override
  void abort() {
    onTerminate(BehaviorStatus.aborted);
    behaviorStatus = BehaviorStatus.aborted;
  }

  @override
  bool isTerminated() {
    return behaviorStatus == BehaviorStatus.success || behaviorStatus == BehaviorStatus.failure;
  }

  @override
  bool isRunning() {
    return behaviorStatus == BehaviorStatus.running;
  }

  @override
  BehaviorStatus getBehaviorStatus() {
    return behaviorStatus;
  }

  @override
  void onInitialize() {}

  @override
  void onTerminate(BehaviorStatus behaviorStatus) {}
}