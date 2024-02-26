import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';

class DeliveryOrderItem extends StatelessWidget {
  final String title;
  final String content;

  const DeliveryOrderItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: appStyle(
            14,
            AppColors.white,
            FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          content,
          style: appStyle(
            13,
            AppColors.white,
            FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          height: 2,
          color: AppColors.grey,
        ),
      ],
    );
  }
}
