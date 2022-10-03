import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_play/question.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_play/result_dialog.dart';
import 'package:lottie/lottie.dart';

class QuizPlay extends StatefulWidget {
  const QuizPlay({Key? key}) : super(key: key);

  @override
  State<QuizPlay> createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> {
  int _questionIndex = 0;
  double _containerHeight = 0;
  Future<void> _isCorrectAnswerChosen(
      int answer, int chosenOption, String correctOptionText) async {
    await showDialog(
        context: context,
        builder: (_) => ResultDialog(
            isCorrect: answer == chosenOption,
            correctAnswer: correctOptionText));

    setState(() {
      _containerHeight = 800;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _questionIndex += 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
    final questions = arguments['quiz_questions'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(arguments['quiz_title'])),
      body: Stack(
        children: [
          _questionIndex < questions.length
              ? Question(
                  question: questions[_questionIndex],
                  chooseAnswer: _isCorrectAnswerChosen,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Hero(
                        tag: 'completeQuiz',
                        child: SizedBox(
                            height: 250,
                            width: 250,
                            child: Lottie.asset(
                                'assets/animations/quizComplete.json')),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'AWESOME!',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF6ab685)),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          'You\'ve completed the quiz!',
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[800]),
                        ))),
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Go back to quizzes')),
                  ],
                ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _containerHeight),
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 500),
            builder: (BuildContext context, double height, Widget? child) {
              return Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width,
                height: height,
              );
            },
            onEnd: () => {
              setState(() {
                _containerHeight = 0;
              })
            },
          ),
        ],
      ),
    );
  }
}
