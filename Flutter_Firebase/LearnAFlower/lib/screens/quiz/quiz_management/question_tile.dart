import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile(
      {Key? key,
      required this.questionInfo,
      required this.quizId,
      required this.questionId,
      required this.editQuestion})
      : super(key: key);
  final Map<String, dynamic> questionInfo;
  final int questionId;
  final String quizId;
  final Function editQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Hero(
              tag: questionInfo['image'].toString(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Image.network(
                  questionInfo['image'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionInfo['question'] == ""
                  ? const SizedBox()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        questionInfo['question'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
              const SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  'Answer: ${questionInfo['options'][questionInfo['answer']].toString()}',
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => editQuestion(questionId),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.primary),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(8, 27.5, 8, 27.5),
                child: Center(
                    child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 22,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
