import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key, required this.child, required this.title})
      : super(key: key);
  final Widget child;
  final String title;

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: AppColors.appBackground,
      body: widget.child,
    );
  }
}
