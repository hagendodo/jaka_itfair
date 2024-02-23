import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';

class UserChat extends StatelessWidget {
  const UserChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: MediaQuery.of(context).size.width * 0.30,
        ),
        child: ClipPath(
          clipper: LowerNipMessageClipper(MessageType.send),
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text(
              'Hi Driver  ',
              style: appStyle(14, AppColors.white, FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
