enum BehaviorStatus { invalid, success, failure, running, aborted }

class BehaviorTree {
  Behavior? root;
  void tick() {}
}

class Behavior {
  // Private
  BehaviorStatus behaviorStatus;

  // Public
  Behavior({
    this.behaviorStatus = BehaviorStatus.invalid,
  });

  BehaviorStatus tick() {
    if (behaviorStatus != BehaviorStatus.running) onInitialize();
    behaviorStatus = update();
    if (behaviorStatus != BehaviorStatus.running) onTerminate(behaviorStatus);
    return behaviorStatus;
  }

  // Protected
  void onInitialize() {}

  BehaviorStatus update() {
    return BehaviorStatus.invalid;
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

  void onTerminate(BehaviorStatus behaviorStatus) {}
}

class Composite extends Behavior {
  // Public
  void addChild(Behavior behavior) {
    behaviorList.add(behavior);
  }

  void removeChild(Behavior behavior) {
    behaviorList.remove(behavior);
  }

  void clearChild() {
    behaviorList.clear();
  }

  // Protected
  List<Behavior> behaviorList = List<Behavior>.empty(growable: true);
}

class Sequence extends Composite {
  // Protected
  @override
  void onInitialize() {}

  @override
  BehaviorStatus update() {
    for (int i = 0; i < behaviorList.length; i++) {
      BehaviorStatus behaviorStatus = behaviorList[i].tick();

      if (behaviorStatus != BehaviorStatus.success) {
        return behaviorStatus;
      }
    }
    return BehaviorStatus.success;
  }
}
