// food.dart
import 'dart:math';
import 'dart:ui';
import 'snake.dart';

class Food {
  Offset position;
  final int gridSize;

  Food({required this.gridSize}) : position = Offset(0.0, 0.0);

  void generateFood(List<Offset> snakeBody) {
    final random = Random();
    do {
      position = Offset(
        random.nextInt(gridSize).toDouble(),
        random.nextInt(gridSize).toDouble(),
      );
    } while (snakeBody.any((segment) => segment == position));
  }
}
