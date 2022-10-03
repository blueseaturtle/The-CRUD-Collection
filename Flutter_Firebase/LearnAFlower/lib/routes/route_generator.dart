import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/common/app_layout.dart';
import 'package:learn_a_flower_app/screens/home/my_home_page.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/edit_question.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/new_question.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/new_quiz.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/questions_list.dart';
import 'package:learn_a_flower_app/screens/home/admin_dashboard.dart';
import 'package:learn_a_flower_app/screens/home/user_dashboard.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/quiz_list.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_play/quiz_play.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_play/quiz_play_list.dart';

class RouteGenerator {
  static dynamic getRoute() {
    return {
      AppRoutes.ADMIN_DASHBOARD: (context) => AdminDashboard(),
      AppRoutes.USER_DASHBOARD: (context) => UserDashboard(),

      //QUIZ PAGES
      AppRoutes.QUIZ_MANAGEMENT_LIST: (context) =>
          const AppLayout(child: QuizList(), title: 'Quiz Management'),
      AppRoutes.QUIZ_MANAGEMENT_QUESTIONS: (context) => const QuestionList(),
      AppRoutes.QUIZ_MANAGEMENT_NEW_QUESTION: (context) => const NewQuestion(),
      AppRoutes.QUIZ_MANAGEMENT_NEW_QUIZ: (context) => const NewQuiz(),
      AppRoutes.QUIZ_PLAY_LIST: (context) =>
          const AppLayout(child: QuizPlayList(), title: 'Play a Quiz'),
      AppRoutes.QUIZ_PLAY: (context) => const QuizPlay(),
      AppRoutes.QUIZ_MANAGEMENT_EDIT_QUESTION: (context) =>
          const EditQuestion(),
    };
  }
}
