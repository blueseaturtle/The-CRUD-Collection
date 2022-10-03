import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/widgets/app_bar_title.dart';

class AdminDashboard extends StatelessWidget {
  AdminDashboard({Key? key}) : super(key: key);

  final List<String> _listFireItems = [
    'Flower Management',
    'Flower Disease Management',
    'Quiz Management',
  ];

  final List<String> _listFireIcons = [
    'assets/roses.png',
    'assets/roses.png',
    'assets/roses.png',
  ];

  final List<Widget?> _listFeatureScreens = [
    null,
    null,
    null,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const AppBarTitle(
          title: 'Admin Dashboard',
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 100.0,
            ),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.QUIZ_MANAGEMENT_LIST);
                  },
                  child: const Text("Quiz Management"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
