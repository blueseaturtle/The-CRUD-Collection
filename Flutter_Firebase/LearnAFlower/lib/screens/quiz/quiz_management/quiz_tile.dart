import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/models/quiz.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/common/confirm_alert.dart';
import 'package:learn_a_flower_app/screens/common/custom_alert.dart';
import 'package:learn_a_flower_app/services/quiz_service.dart';

class QuizTile extends StatelessWidget {
  const QuizTile({Key? key, required this.quizInfo, required this.isAdmin})
      : super(key: key);
  final Quiz quizInfo;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return isAdmin
        ? GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'LEVEL',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          quizInfo.level.toString(),
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                    decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  Text(
                    quizInfo.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => ConfirmAlert(
                              alertTitle:
                                  'Are you sure you want to delete this quiz?',
                              onConfirm: () async {
                                dynamic res =
                                    await QuizService.deleteQuiz(quizInfo.id);
                                if (res) {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => const CustomAlert(
                                          isSuccess: true,
                                          alertTitle:
                                              'Quiz deleted successfully'));
                                  Navigator.popAndPushNamed(
                                      context, AppRoutes.QUIZ_MANAGEMENT_LIST);
                                } else {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => const CustomAlert(
                                          isSuccess: false,
                                          alertTitle:
                                              'Unable to delete quiz.\nPlease try again later'));
                                }
                              }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColors.fail),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(8, 27.5, 8, 27.5),
                        child: Center(
                            child: Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                          size: 22,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.QUIZ_MANAGEMENT_QUESTIONS,
                  arguments: {'quiz_info': quizInfo});
            },
          )
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'LEVEL',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        quizInfo.level.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      )
                    ],
                  ),
                  decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                Text(
                  quizInfo.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.QUIZ_PLAY,
                        arguments: {
                          'quiz_questions': quizInfo.questions,
                          'quiz_title': quizInfo.title
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.primaryDark),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(8, 27.5, 8, 27.5),
                      child: Center(
                          child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 22,
                      )),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
