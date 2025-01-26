import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Todo List',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        color: Colors.deepPurple,
      ),
    );
  }
}
