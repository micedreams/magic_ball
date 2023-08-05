import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

final list = [
  "It is certain",
  "It is decidedly so",
  "Without a doubt",
  "Yes - definitely",
  "You may rely on it",
  "As I see it, yes",
  "Most likely",
  "Outlook good",
  "Yes",
  "Signs point to yes",
  "Reply hazy, try again",
  "Ask again later",
  "Better not tell you now",
  "Cannot predict now",
  "Concentrate and ask again",
  "Don't count on it",
  "My reply is no",
  "My sources say no",
  "Outlook not so good",
  "Very doubtful"
];

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> with TickerProviderStateMixin {
  final luckNotifier = ValueNotifier('');

  late final AnimationController magicController;

  @override
  void initState() {
    super.initState();

    magicController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    magicController.addStatusListener(onStatusListener);
  }

  void onStatusListener(status) async {
    if (status != AnimationStatus.completed) {
      return;
    }

    magicController.reset();

    Future.delayed(
      const Duration(seconds: 2),
      () => luckNotifier.value = '',
    );
  }

  void setValue() {
    magicController.forward();

    final rng = Random();
    final randomNum = rng.nextInt(list.length);
    if (list[randomNum] == luckNotifier.value) {
      setValue();
    } else {
      luckNotifier.value = list[randomNum];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ask a question and tap the magic ball',
          style: TextStyle(color: colorScheme.inversePrimary),
        ),
        Center(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: setValue,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Lottie.asset(
                  'assets/magic_ball.json',
                  repeat: false,
                  controller: magicController,
                ),
                Lottie.asset('assets/candle.json'),
                ValueListenableBuilder<String>(
                  builder: (context, value, _) => Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Text(
                      value,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  valueListenable: luckNotifier,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
