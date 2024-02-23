import 'package:flutter/material.dart';
import 'package:user_jaka/constants/constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, required this.containerContent, required this.color});

  final Widget containerContent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: width,
      child: ClipRRect(
        child: Container(
          width: width,
          color: color,
          child: SingleChildScrollView(
            child: containerContent,
          ),
        ),
      ),
    );
  }
}
