import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/quiz.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/quiz_tile.dart';
import 'package:learn_a_flower_app/services/quiz_service.dart';
import 'package:lottie/lottie.dart';

class QuizPlayList extends StatefulWidget {
  const QuizPlayList({Key? key}) : super(key: key);

  @override
  State<QuizPlayList> createState() => _QuizPlayListState();
}

class _QuizPlayListState extends State<QuizPlayList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<dynamic> _onRefresh() async {
    setState(() {});
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      key: _refreshIndicatorKey,
      child: FutureBuilder(
          future: QuizService.getQuizList(0),
          builder: (BuildContext context, AsyncSnapshot<List<Quiz>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, right: 20, bottom: 10),
                          child: QuizTile(
                            quizInfo: snapshot.data![index],
                            isAdmin: false,
                          ),
                        );
                      }),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                        height: 250,
                        width: 250,
                        child: Lottie.asset("assets/animations/addData.json")),
                    Text(
                      'No quizzes',
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    )
                  ],
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
