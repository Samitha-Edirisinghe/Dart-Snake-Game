import 'dart:async';

import 'package:flutter/material.dart';
import 'snake.dart';
import 'food.dart';
import 'direction.dart';
import 'game_painter.dart';

class SnakeGameScreen extends StatefulWidget {
  @override
  _SnakeGameScreenState createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  final int gridSize = 20;
  late Snake snake;
  late Food food;
  Direction direction = Direction.right;
  int score = 0;
  Timer? gameTimer;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      snake = Snake(gridSize: gridSize); // Reset the snake
      food = Food(gridSize: gridSize); // Reset the food
      food.generateFood(snake.body); // Generate new food
      gameOver = false; // Reset game over state
      score = 0; // Reset score
      direction = Direction.right; // Reset direction
    });

    gameTimer?.cancel(); // Cancel the existing timer
    gameTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      moveSnake();
    });
  }

  void moveSnake() {
    if (gameOver) return;

    Offset newHead = snake.move(direction);

    if (snake.checkCollision(gridSize)) {
      setState(() {
        gameOver = true;
      });
      gameTimer?.cancel();
      return;
    }

    if (newHead == food.position) {
      setState(() {
        snake.grow();
        score++;
        food.generateFood(snake.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * 0.9;
    final tileSize = size / gridSize;

    return Scaffold(
      appBar: AppBar(
        title: Text('Snake Game - Score: $score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: CustomPaint(
                painter: GamePainter(
                  snake: snake.body,
                  food: food.position,
                  tileSize: tileSize,
                  gameOver: gameOver,
                ),
              ),
            ),
            if (gameOver)
              ElevatedButton(
                onPressed: startGame, // Call startGame to reset the game
                child: Text('Play Again'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }
}
