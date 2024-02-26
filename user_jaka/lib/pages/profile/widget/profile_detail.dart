import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:user_jaka/pages/profile/widget/profile_edit.dart';
import 'package:user_jaka/pages/profile/widget/profile_item.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController fecthData = SignInController();
    return FutureBuilder<Map<String, dynamic>?>(
      future: fecthData.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Map<String, dynamic>? userData = snapshot.data;
          String name = userData?['user']['name'] ?? 'Name Not Found';
          String phone = userData?['user']['phone'] ?? 'Number Not Found';
          String nim = userData?['user']['nim'] ?? 'Nim Not Found';
          String email = userData?['user']['email'] ?? 'Email Not Found';

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
                                    backgroundImage: const AssetImage(
                                        'assets/img/user_profile.jpg'),
                                    radius: 50.r,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    name,
                                    style: appStyle(
                                        20, AppColors.black, FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    nim,
                                    style: appStyle(
                                        13, AppColors.grey, FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ProfileItem(
                                    title: 'Fullname',
                                    value: name,
                                  ),
                                  ProfileItem(
                                    title: 'NIM',
                                    value: nim,
                                  ),
                                  ProfileItem(
                                    title: 'Phone Number',
                                    value: phone,
                                  ),
                                  ProfileItem(
                                    title: 'Email',
                                    value: email,
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
      },
    );
  }
}
