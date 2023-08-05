import 'package:flutter/material.dart';
import 'dart:math';

import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(),
    );
  }
}

final list = [
  'yes',
  'no',
  'maybe',
  'ask agian',
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final indexNotifier = ValueNotifier(0);

  void _randomValue() {
    var rng = Random();
    final randomNum = rng.nextInt(list.length);
    if (indexNotifier.value == randomNum) {
      _randomValue();
    } else {
      indexNotifier.value = randomNum;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Magic ball'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: _randomValue,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Lottie.asset('assets/magic_ball.json'),
              ValueListenableBuilder<int>(
                builder: (context, value, _) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Text(
                      list[value],
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                },
                valueListenable: indexNotifier,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
