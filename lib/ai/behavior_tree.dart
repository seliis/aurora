class Node {
  bool invoke() => false;
}

class CompositeNode extends Node {
  final List<Node> _nodeList = <Node>[];

  void addNode(Node node) => _nodeList.add(node);
  List<Node> getNodeList() => _nodeList;
}

class Selector extends CompositeNode {
  @override
  bool invoke() {
    for (Node node in getNodeList()) {
      if (node.invoke()) return true;
    }
    return false;
  }
}

class Sequence extends CompositeNode {
  @override
  bool invoke() {
    for (Node node in getNodeList()) {
      if (!node.invoke()) return false;
    }
    return true;
  }
}
