import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  final VoidCallback? onTap;
  final String title;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        color: backgroundColor),
                    child: Icon(
                      icon,
                      color: color,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    title,
                    style: appStyle(14.sp, AppColors.black, FontWeight.bold),
                  ),
                ],
              ),
              const Icon(
                CupertinoIcons.forward,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
