import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/question_tile.dart';
import 'package:lottie/lottie.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<dynamic> _onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
    final questions = arguments['quiz_info'].questions as List<dynamic>;

    void _editQuestion(int index) {
      Navigator.pushNamed(
        context,
        AppRoutes.QUIZ_MANAGEMENT_EDIT_QUESTION,
        arguments: {'quiz_info': arguments['quiz_info'], 'question_id': index},
      );
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: Scaffold(
        appBar: AppBar(title: Text(arguments['quiz_info'].title)),
        floatingActionButton: questions.isEmpty
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.QUIZ_PLAY, arguments: {
                    'quiz_questions': questions,
                    'quiz_title': arguments['quiz_info'].title
                  });
                },
                child: const Icon(Icons.play_arrow_rounded),
                tooltip: 'Preview this quiz',
              ),
        backgroundColor: AppColors.appBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: ListView.builder(
              itemCount: questions.isEmpty ? 2 : questions.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                        child: ElevatedButton(
                          child: Row(
                            children: const [
                              Text(
                                "+ ",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                " Add new question",
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.QUIZ_MANAGEMENT_NEW_QUESTION,
                                arguments: {
                                  'quiz_info': arguments['quiz_info']
                                });
                          },
                        ),
                      ),
                    ],
                  );
                } else if (questions.length + 1 == 1) {
                  return Column(
                    children: [
                      SizedBox(
                          height: 250,
                          width: 250,
                          child:
                              Lottie.asset('assets/animations/addData.json')),
                      Text(
                        'No questions',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    child: QuestionTile(
                      quizId: arguments['quiz_info'].id,
                      questionId: index - 1,
                      questionInfo: questions[index - 1],
                      editQuestion: _editQuestion,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
