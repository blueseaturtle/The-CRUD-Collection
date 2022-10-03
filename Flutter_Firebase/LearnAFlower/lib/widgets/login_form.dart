import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/validator.dart';
import 'package:learn_a_flower_app/screens/home/admin_dashboard.dart';
import 'package:learn_a_flower_app/screens/home/user_dashboard.dart';
import 'package:learn_a_flower_app/widgets/custom_form_field.dart';

class LoginForm extends StatefulWidget {
  final FocusNode focusNode;

  const LoginForm({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _uidController = TextEditingController();

  final _loginInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginInFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 30.0,
            ),
            child: Column(
              children: [
                CustomFormField(
                  controller: _uidController,
                  focusNode: widget.focusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateUserID(
                    uid: value,
                  ),
                  label: 'User Name',
                  hint: 'Enter your username (admin / user)',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.green,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  widget.focusNode.unfocus();

                  if (_loginInFormKey.currentState!.validate()) {
                    if (_uidController.text == 'admin') {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AdminDashboard(),
                        ),
                      );
                    } else {
                      // _uidController.text = 'user';
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => UserDashboard(),
                        ),
                      );
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
