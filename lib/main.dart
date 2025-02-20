// main.dart
import 'package:flutter/material.dart';
import 'snake_game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData.dark(),
      home: SnakeGameScreen(),
    );
  }
}
