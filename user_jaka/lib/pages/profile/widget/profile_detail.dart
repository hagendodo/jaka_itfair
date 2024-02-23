import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/profile/widget/profile_edit.dart';
import 'package:user_jaka/pages/profile/widget/profile_item.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: Text(
          'Settings',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(
                () => const EditProfile(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 900),
              );
            },
            child: Text(
              'Edit',
              style: appStyle(
                13,
                AppColors.primary,
                FontWeight.w600,
              ),
            ),
          )
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
                            Text(
                              'Muhammad Aldzikri Fahlevi',
                              style: appStyle(
                                  20, AppColors.black, FontWeight.bold),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '08721213123',
                              style:
                                  appStyle(13, AppColors.grey, FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ProfileItem(
                              title: 'Fullname',
                              value: 'Muhammad Aldzikri Fahlevi',
                            ),
                            const ProfileItem(
                              title: 'NIM',
                              value: '1217050120',
                            ),
                            const ProfileItem(
                              title: 'Phone Number',
                              value: '0312321312',
                            ),
                            const ProfileItem(
                              title: 'Email',
                              value: 'Dummy@gmail.com',
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
