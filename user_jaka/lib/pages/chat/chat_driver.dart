import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/chat/widget/bottomsheet_message_send.dart';
import 'package:user_jaka/pages/chat/widget/driver_chat.dart';
import 'package:user_jaka/pages/chat/widget/user_chat.dart';

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
      body: ListView(
        padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 80),
        children: [
          Container(
            padding: EdgeInsets.only(top: 5.h),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.h),
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
            height: 10.h,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DriverChat(),
              UserChat(),
            ],
          )
        ],
      ),
      bottomSheet: const ChatBottomSheet(),
    );
  }
}
