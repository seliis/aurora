import "package:aurora/ai/behavior_tree/behavior_node.dart";

abstract class BehaviorCompositeAbstract extends BehaviorNode {
  // Public
  void addChild(BehaviorNode behaviorNode);
  void removeChild(BehaviorNode behaviorNode);
  void clearChildren();

  // Private
  List<BehaviorNode> behaviorNodeList = List<BehaviorNode>.empty(growable: true);
}

class BehaviorComposite extends BehaviorCompositeAbstract {
  @override
  void addChild(BehaviorNode behaviorNode) {
    behaviorNodeList.add(behaviorNode);
  }

  @override
  void removeChild(BehaviorNode behaviorNode) {
    behaviorNodeList.remove(behaviorNode);
  }

  @override
  void clearChildren() {
    behaviorNodeList.clear();
  }
}
