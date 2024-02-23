import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';

class ChatDriver extends StatelessWidget {
  const ChatDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.primary,
              backgroundImage: AssetImage('assets/img/avatar.png'),
            ),
            SizedBox(
              width: 5.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: 'Raden Ibnu',
                  style: appStyle(13, AppColors.black, FontWeight.bold),
                ),
                ReusableText(
                  text: '08721121312',
                  style: appStyle(10, AppColors.grey, FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey.shade200,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    alignment: Alignment.center,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: ReusableText(
                        text: 'Today',
                        style: appStyle(10, Colors.white70, FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 3.h),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Ini User sayasa!',
                                style: appStyle(
                                    12, AppColors.white, FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColors.primary,
                              backgroundImage:
                                  AssetImage('assets/img/avatar.png'),
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.h, vertical: 3.h),
                              decoration: const BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Ini Driver, siap mbanya mohon',
                                style: appStyle(
                                    12, AppColors.white, FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
