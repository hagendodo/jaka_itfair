import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';

class DriverChat extends StatelessWidget {
  const DriverChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.30,
      ),
      child: ClipPath(
        clipper: UpperNipMessageClipper(MessageType.receive),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
          ),
          child: Text(
            'Hi, Developer How Are Youdas dssad?',
            style: appStyle(13, AppColors.white, FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
