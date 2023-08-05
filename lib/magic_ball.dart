import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final list = [
  'yes',
  'no',
  'maybe',
  'ask agian',
];

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  final indexNotifier = ValueNotifier(0);

  void randomValue() {
    final rng = Random();
    final randomNum = rng.nextInt(list.length);
    if (indexNotifier.value == randomNum) {
      randomValue();
    } else {
      indexNotifier.value = randomNum;
    }
  }

  @override
  Widget build(BuildContext context) => Center(
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: randomValue,
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
      );
}
