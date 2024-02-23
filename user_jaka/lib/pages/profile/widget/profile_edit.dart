import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/profile/widget/profile_textfield.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: appStyle(
            15,
            AppColors.black,
            FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Done',
              style: appStyle(
                13,
                AppColors.primary,
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              backgroundImage:
                                  const AssetImage('assets/img/avatar.png'),
                              radius: 50.r,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Edit Photo',
                                style: appStyle(
                                    12, AppColors.grey, FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ProfileTextField(
                              title: 'Fullname',
                              controller: TextEditingController(),
                              cursorColor: AppColors.black,
                            ),
                            ProfileTextField(
                              title: 'NIM',
                              controller: TextEditingController(),
                              cursorColor: AppColors.black,
                            ),
                            ProfileTextField(
                              title: 'Phone Number',
                              controller: TextEditingController(),
                              cursorColor: AppColors.black,
                            ),
                            ProfileTextField(
                              title: 'Email',
                              controller: TextEditingController(),
                              cursorColor: AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
