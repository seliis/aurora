// ignore_for_file: avoid_print
import "package:aurora/ai/behavior_tree.dart";
import "dart:io";

void main() async {
  Sequence root = Sequence();
  Selector selector = Selector();

  Sequence seqMove = Sequence();
  Sequence seqAttack = Sequence();

  Node isDead = Node();
  Node isContact = Node();
  Node attack = Node();
  Node move = Node();

  root.addNode(selector);
  root.addNode(isDead);

  selector.addNode(seqAttack);
  selector.addNode(seqMove);

  seqAttack.addNode(isContact);
  seqAttack.addNode(attack);

  seqMove.addNode(move);

  while (!root.invoke()) {
    print("---");
    sleep(const Duration(seconds: 1));
  }
}
