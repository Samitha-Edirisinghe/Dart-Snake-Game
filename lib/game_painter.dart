// game_painter.dart
import 'package:flutter/material.dart';

class GamePainter extends CustomPainter {
  final List<Offset> snake;
  final Offset food;
  final double tileSize;
  final bool gameOver;

  GamePainter({
    required this.snake,
    required this.food,
    required this.tileSize,
    required this.gameOver,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    if (gameOver) {
      _drawGameOver(canvas, size);
      return;
    }
    _drawSnake(canvas);
    _drawFood(canvas);
  }

  void _drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.black,
    );
  }

  void _drawGameOver(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'GAME OVER',
        style: TextStyle(color: Colors.red, fontSize: 40),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  void _drawSnake(Canvas canvas) {
    final paint = Paint()..color = Colors.green;
    for (final segment in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          segment.dx * tileSize,
          segment.dy * tileSize,
          tileSize,
          tileSize,
        ),
        paint,
      );
    }
  }

  void _drawFood(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
        food.dx * tileSize,
        food.dy * tileSize,
        tileSize,
        tileSize,
      ),
      Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
