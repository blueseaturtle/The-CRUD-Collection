import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfirmAlert extends StatelessWidget {
  const ConfirmAlert(
      {Key? key, required this.alertTitle, required this.onConfirm})
      : super(key: key);
  final String alertTitle;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.all(15),
        height: 200,
        width: 200,
        child: Lottie.asset('assets/animations/confirm.json'),
      ),
      content: Text(
        alertTitle,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Yes'),
          onPressed: () => onConfirm(),
        ),
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () => {Navigator.pop(context)},
        )
      ],
    );
  }
}
