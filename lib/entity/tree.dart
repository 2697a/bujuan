import 'package:bujuan/entity/node.dart';

class Tree {
  Node root;
  int length;

  Tree();

  void put(int v) {
    if (root == null) {
      this.root = new Node(null, v, null, null);
      return;
    }

    Node node = this.root;
    if (node.curr == v) {
      return;
    }


  }

  Node getNextNode(Node node, int v) {
    Node temp = node;
//    if (temp != null) {
//      return getNextNode(temp, v);
//    }



    if (v > temp.curr) {
      temp = node.right;
    }
    if (v < temp.curr) {
      temp = node.left;
    }
    if (temp == null) {

    }

    return node;
  }

}