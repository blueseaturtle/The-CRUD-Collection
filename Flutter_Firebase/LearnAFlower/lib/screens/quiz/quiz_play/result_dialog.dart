import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultDialog extends StatefulWidget {
  const ResultDialog(
      {Key? key, required this.isCorrect, required this.correctAnswer})
      : super(key: key);
  final bool isCorrect;
  final String correctAnswer;

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  @override
  Widget build(BuildContext context) {
    return widget.isCorrect
        ? CupertinoAlertDialog(
            title: Container(
              padding: const EdgeInsets.all(15),
              height: 200,
              width: 200,
              child: Lottie.asset('assets/animations/correctAnswer.json'),
            ),
            content: Column(
              children: [
                Text(
                  'Yes!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'It\'s ${widget.correctAnswer}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Next'),
                onPressed: () => {Navigator.pop(context)},
              )
            ],
          )
        : CupertinoAlertDialog(
            title: Container(
              padding: const EdgeInsets.all(15),
              height: 200,
              width: 200,
              child: Lottie.asset('assets/animations/wrongAnswer.json'),
            ),
            content: Column(
              children: [
                Text(
                  'Oops',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'It\'s ${widget.correctAnswer}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Next'),
                onPressed: () => {Navigator.pop(context)},
              )
            ],
          );
  }
}
