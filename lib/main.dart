import 'package:flutter/material.dart';

import 'magic_ball.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffFDBE50),
          background: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const Scaffold(body: MagicBall()),
    );
  }
}
