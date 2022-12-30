import "package:aurora/ai/behavior_tree/behavior_composite.dart";
import "package:aurora/ai/behavior_tree/behavior_status.dart";

class BehaviorSelector extends BehaviorComposite {
  @override
  BehaviorStatus update() {
    int index = 0;
    while (true) {
      BehaviorStatus behaviorStatus = behaviorNodeList[index].tick();
      if (behaviorStatus != BehaviorStatus.failure) {
        return behaviorStatus;
      }
      if (++index == behaviorNodeList.length) {
        return BehaviorStatus.failure;
      }
    }
  }
}
