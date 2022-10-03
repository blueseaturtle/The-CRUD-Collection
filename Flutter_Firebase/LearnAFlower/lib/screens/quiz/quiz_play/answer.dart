import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String optionText;

  const Answer(
      {Key? key, required this.selectHandler, required this.optionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: InkWell(
            splashColor: AppColors.primary,
            onTap: selectHandler,
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(10),
                child: Text(
                  optionText,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.green[700]),
                )),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
