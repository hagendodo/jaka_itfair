import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/custom_container.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:user_jaka/pages/auth/signin_page.dart';
import 'package:user_jaka/pages/profile/widget/document_management.dart';
import 'package:user_jaka/pages/profile/widget/menu_profile.dart';
import 'package:user_jaka/pages/profile/widget/profile_detail.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          String? name = userData?['user']['name'];
          String? nim = userData?['user']['nim'];

          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: AppColors.white,
              title: Text(
                'Profile',
                style: appStyle(22, AppColors.black, FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: CustomContainer(
                color: Colors.grey.shade200,
                containerContent: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const ProfileDetail(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 900),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.h, vertical: 10.h),
                        color: AppColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 37.r,
                              backgroundColor: AppColors.primary,
                              backgroundImage: const AssetImage(
                                  'assets/img/user_profile.jpg'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name ?? 'Name Not Found',
                                    style: appStyle(
                                        16, AppColors.black, FontWeight.bold),
                                    softWrap: true,
                                  ),
                                  ReusableText(
                                    text: nim ?? 'NIM Not Found',
                                    style: appStyle(
                                        13, AppColors.grey, FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.forward,
                              color: AppColors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Column(
                        children: [
                          ProfileMenu(
                            onTap: () {
                              Get.to(
                                () => const DocumentManagement(),
                                transition: Transition.cupertino,
                                duration: const Duration(
                                  milliseconds: 900,
                                ),
                              );
                            },
                            backgroundColor: Colors.green,
                            title: 'Document Management',
                            icon: CupertinoIcons.doc_person,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Column(
                            children: [
                              const ProfileMenu(
                                backgroundColor: AppColors.primary,
                                title: 'Notifications',
                                icon: CupertinoIcons.bell_fill,
                                color: AppColors.white,
                              ),
                              const ProfileMenu(
                                backgroundColor: AppColors.grey,
                                title: 'Term &  Privacy',
                                icon: CupertinoIcons.exclamationmark_octagon,
                                color: AppColors.white,
                              ),
                              ProfileMenu(
                                onTap: () {},
                                backgroundColor: Colors.redAccent,
                                title: 'Contact Us',
                                icon: CupertinoIcons.chat_bubble_2_fill,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              ProfileMenu(
                                  onTap: () async {
                                    await LogoutController.logout();

                                    Get.off(() => const SignInPage());
                                  },
                                  title: 'Logout',
                                  icon: Icons.logout_outlined,
                                  color: AppColors.white,
                                  backgroundColor: AppColors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
