// main.dart
// Coding by Samitha Randika | https://www.linkedin.com/in/samitha-randika-edirisinghe-b3a68a2b6 //
import 'package:flutter/material.dart';
import 'snake_game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData.dark(),
      home: SnakeGameScreen(),
    );
  }
}
