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
      snake = Snake(gridSize: gridSize);
      food = Food(gridSize: gridSize);
      food.generateFood(snake.body);
      gameOver = false;
      score = 0;
      direction = Direction.right;
    });

    gameTimer?.cancel();
    gameTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (!gameOver) moveSnake();
    });
  }

  void moveSnake() {
    final newHead = snake.move(direction);
    if (snake.checkCollision(gridSize)) {
      setState(() => gameOver = true);
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
      appBar: AppBar(title: Text('Snake Game - Score: $score')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
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
          ),
          _buildControlButtons(),
          if (gameOver)
            ElevatedButton(
              onPressed: startGame,
              child: Text('Play Again'),
            ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () => _updateDirection(Direction.up),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _updateDirection(Direction.left),
              ),
              SizedBox(width: 48),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _updateDirection(Direction.right),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () => _updateDirection(Direction.down),
          ),
        ],
      ),
    );
  }

  void _updateDirection(Direction newDirection) {
    if ((direction == Direction.up && newDirection == Direction.down) ||
        (direction == Direction.down && newDirection == Direction.up) ||
        (direction == Direction.left && newDirection == Direction.right) ||
        (direction == Direction.right && newDirection == Direction.left)) {
      return;
    }
    setState(() => direction = newDirection);
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }
}
