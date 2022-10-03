import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/routes/route_generator.dart';
import 'package:learn_a_flower_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn A Flower',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: AppColors.primary,
      ),
      routes: RouteGenerator.getRoute(),
      home: const LoginScreen(),
    );
  }
}
