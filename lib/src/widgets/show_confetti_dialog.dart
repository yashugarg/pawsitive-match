import 'package:flutter/material.dart';

import 'package:confetti/confetti.dart';

Future<T?> showConfettiDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Alignment confettiAlignment = Alignment.center,
}) {
  final Widget pageBuilder = Builder(builder: builder);
  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 2));
  confettiController.play();
  return showDialog<T>(
    context: context,
    builder: (BuildContext buildContext) {
      return Stack(
        children: [
          pageBuilder,
          Align(
            alignment: confettiAlignment,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.1,
            ),
          ),
        ],
      );
    },
  );
}
