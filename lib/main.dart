import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  const MyHomePage({
    super.key,
  });

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
        title: const Text('Magic_ball'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder<int>(
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    list[value],
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                );
              },
              valueListenable: indexNotifier,
            ),
            FloatingActionButton(
              onPressed: _randomValue,
              tooltip: 'again',
              child: const Icon(Icons.replay),
            )
          ],
        ),
      ),
    );
  }
}
