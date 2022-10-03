import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_play/answer.dart';

class Question extends StatelessWidget {
  final Map<String, dynamic> question;
  final Function chooseAnswer;
  const Question({Key? key, required this.question, required this.chooseAnswer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _correctAnswer = question['options'][question['answer']];
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Hero(
              tag: question['image'].toString(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  question['image'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            question['question'].toString(),
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 35),
          ...(question['options'] as List<dynamic>)
              .asMap()
              .entries
              .map((option) => Answer(
                    selectHandler: () => chooseAnswer(
                      question['answer'],
                      option.key,
                      _correctAnswer,
                    ),
                    optionText: option.value,
                  ))
        ],
      ),
    );
  }
}
