enum BehaviorStatus { invalid, success, failure, running, aborted }

class BehaviorTree {
  Behavior? root;
  void tick() {}
}

class Behavior {
  Behavior({this.behaviorStatus = BehaviorStatus.invalid});

  BehaviorStatus behaviorStatus;

  BehaviorStatus tick() {
    if (behaviorStatus != BehaviorStatus.running) onInitialize();
    behaviorStatus = update();
    if (behaviorStatus != BehaviorStatus.running) onTerminate(behaviorStatus);
    return behaviorStatus;
  }

  void reset() {
    behaviorStatus = BehaviorStatus.invalid;
  }

  void abort() {
    onTerminate(BehaviorStatus.aborted);
    behaviorStatus = BehaviorStatus.aborted;
  }

  bool isTerminated() {
    return behaviorStatus == BehaviorStatus.success || behaviorStatus == BehaviorStatus.failure;
  }

  bool isRunning() {
    return behaviorStatus == BehaviorStatus.running;
  }

  BehaviorStatus getBehaviorStatus() {
    return behaviorStatus;
  }

  BehaviorStatus update() {
    return BehaviorStatus.invalid;
  }

  void onInitialize() {}
  void onTerminate(BehaviorStatus behaviorStatus) {}
}
