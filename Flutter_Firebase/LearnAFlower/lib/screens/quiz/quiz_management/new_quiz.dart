import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/models/quiz.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/common/custom_alert.dart';
import 'package:learn_a_flower_app/services/quiz_service.dart';
import 'package:lottie/lottie.dart';
import 'package:select_form_field/select_form_field.dart';

class NewQuiz extends StatefulWidget {
  const NewQuiz({Key? key}) : super(key: key);

  @override
  State<NewQuiz> createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuiz> {
  dynamic progress;
  bool firstLoad = true;
  final String errorText = 'This field is required';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  String _valueChanged = '';

  final List<Map<String, dynamic>> _levels = [
    {'value': '1', 'label': 'Level 1'},
    {'value': '2', 'label': 'Level 2'},
    {'value': '3', 'label': 'Level 3'},
    {'value': '4', 'label': 'Level 4'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create a new quiz')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(15),
                height: 250,
                width: 250,
                child: Lottie.asset('assets/animations/newQuizFlower.json'),
              ),
              ListTile(
                leading: const Icon(Icons.yard_rounded,
                    color: AppColors.primaryDark),
                title: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return errorText;
                      }
                      return null;
                    },
                    style: const TextStyle(fontSize: 16),
                    controller: _titleController,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 16),
                        labelText: 'Quiz Title')),
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart_rounded,
                    color: AppColors.primaryDark),
                title: SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  controller: _levelController,
                  labelText: 'Quiz Level',
                  items: _levels,
                  onChanged: (value) => setState(() {
                    _valueChanged = value;
                  }),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                child:
                    const Text("Create Quiz", style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Quiz newQuiz = Quiz.newQuiz(
                        id: UniqueKey().toString(),
                        title: _titleController.text,
                        level: int.parse(_levelController.text));

                    dynamic result = await QuizService.addNewQuiz(newQuiz);
                    if (result.runtimeType == String) {
                      await showDialog(
                          context: context,
                          builder: (_) => CustomAlert(
                              isSuccess: false, alertTitle: result.toString()));
                    } else if (result) {
                      await showDialog(
                          context: context,
                          builder: (_) => const CustomAlert(
                              isSuccess: true,
                              alertTitle: 'New quiz added successfully'));
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(
                          context, AppRoutes.QUIZ_MANAGEMENT_LIST);
                    } else {
                      await showDialog(
                          context: context,
                          builder: (_) => const CustomAlert(
                              isSuccess: false,
                              alertTitle:
                                  'Unable to add quiz.\nPlease try again later'));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
