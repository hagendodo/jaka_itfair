import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 70.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              ReusableText(
                text: 'Page 2',
                style: appStyle(16, AppColors.black, FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
