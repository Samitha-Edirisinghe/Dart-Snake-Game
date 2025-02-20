// snake.dart
import 'dart:math';
import 'dart:ui';
import 'direction.dart';

class Snake {
  List<Offset> body;
  final int gridSize;
  int pendingGrowth = 0;

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

    if (pendingGrowth > 0) {
      pendingGrowth--;
    } else {
      body.removeLast();
    }

    return newHead;
  }

  void grow() {
    pendingGrowth++;
  }

  bool checkCollision(int gridSize) {
    final head = body.first;
    if (head.dx < 0 ||
        head.dx >= gridSize ||
        head.dy < 0 ||
        head.dy >= gridSize) {
      return true;
    }
    return body.skip(1).any((segment) => segment == head);
  }
}
