import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert(
      {Key? key, required this.isSuccess, required this.alertTitle})
      : super(key: key);
  final bool isSuccess;
  final String alertTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.all(15),
        height: 200,
        width: 200,
        child: Lottie.asset(
            'assets/animations/${isSuccess ? 'success.json' : 'fail.json'}'),
      ),
      content: Text(
        alertTitle,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
