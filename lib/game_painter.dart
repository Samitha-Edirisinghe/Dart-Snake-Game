// Coding by Samitha Randika | https://www.linkedin.com/in/samitha-randika-edirisinghe-b3a68a2b6 //
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
    _drawFood(canvas);
    _drawSnake(canvas);
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
    final gradient = LinearGradient(
      colors: [Colors.green, Colors.lightGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    for (int i = 0; i < snake.length; i++) {
      final segment = snake[i];
      final rect = Rect.fromLTWH(
        segment.dx * tileSize,
        segment.dy * tileSize,
        tileSize,
        tileSize,
      );

      // Draw rounded body segments
      final paint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.fill;

      final radius = tileSize / 4;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius)),
        paint,
      );

      // Draw eyes on the head
      if (i == 0) {
        final eyeRadius = tileSize / 8;
        final eyeOffset = tileSize / 4;
        canvas.drawCircle(
          Offset(segment.dx * tileSize + eyeOffset,
              segment.dy * tileSize + eyeOffset),
          eyeRadius,
          Paint()..color = Colors.white,
        );
        canvas.drawCircle(
          Offset(segment.dx * tileSize + tileSize - eyeOffset,
              segment.dy * tileSize + eyeOffset),
          eyeRadius,
          Paint()..color = Colors.white,
        );
      }

      // Draw a pointed tail
      if (i == snake.length - 1) {
        final tailPaint = Paint()
          ..color = Colors.green[700]!
          ..style = PaintingStyle.fill;
        final path = Path();
        path.moveTo(segment.dx * tileSize, segment.dy * tileSize);
        path.lineTo(segment.dx * tileSize + tileSize / 2,
            segment.dy * tileSize + tileSize);
        path.lineTo(segment.dx * tileSize + tileSize, segment.dy * tileSize);
        path.close();
        canvas.drawPath(path, tailPaint);
      }
    }
  }

  void _drawFood(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(
        food.dx * tileSize + tileSize / 2,
        food.dy * tileSize + tileSize / 2,
      ),
      tileSize / 3,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
