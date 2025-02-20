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
    final backgroundPaint = Paint()..color = Colors.black;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    if (gameOver) {
      final textPainter = TextPainter(
        text: TextSpan(
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
      return;
    }

    final snakePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    for (final segment in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          segment.dx * tileSize,
          segment.dy * tileSize,
          tileSize,
          tileSize,
        ),
        snakePaint,
      );
    }

    final foodPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(
        food.dx * tileSize,
        food.dy * tileSize,
        tileSize,
        tileSize,
      ),
      foodPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
