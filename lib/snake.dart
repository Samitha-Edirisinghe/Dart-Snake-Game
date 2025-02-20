import 'dart:ui';
import 'direction.dart';

class Snake {
  List<Offset> body;
  final int gridSize;

  Snake({required this.gridSize})
      : body = [Offset((gridSize ~/ 2).toDouble(), (gridSize ~/ 2).toDouble())];

  Offset move(Direction direction) {
    Offset newHead = body.first;
    switch (direction) {
      case Direction.up:
        newHead = Offset(newHead.dx, newHead.dy - 1);
        break;
      case Direction.down:
        newHead = Offset(newHead.dx, newHead.dy + 1);
        break;
      case Direction.left:
        newHead = Offset(newHead.dx - 1, newHead.dy);
        break;
      case Direction.right:
        newHead = Offset(newHead.dx + 1, newHead.dy);
        break;
    }
    body.insert(0, newHead);
    return newHead;
  }

  void grow() {
    // Snake grows by not removing the tail
  }

  bool checkCollision(int gridSize) {
    Offset head = body.first;
    // Check wall collision
    if (head.dx < 0 ||
        head.dx >= gridSize ||
        head.dy < 0 ||
        head.dy >= gridSize) {
      return true;
    }
    // Check self collision
    for (int i = 1; i < body.length; i++) {
      if (head == body[i]) {
        return true;
      }
    }
    return false;
  }
}
