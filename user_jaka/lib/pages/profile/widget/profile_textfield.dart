import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';

class ProfileTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Color? cursorColor;

  const ProfileTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.cursorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: appStyle(
                14,
                AppColors.black,
                FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.grey,
                ),
              ),
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.grey,
              ),
              cursorColor: cursorColor,
            ),
          ),
        ],
      ),
    );
  }
}
