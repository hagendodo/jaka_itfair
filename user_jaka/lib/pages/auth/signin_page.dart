import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/auth/signup_page.dart';
import 'package:user_jaka/pages/main_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    color: AppColors.primary,
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                left: 10,
                right: 10,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Sign in',
                            style:
                                appStyle(29, AppColors.black, FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          Text(
                            'with',
                            style:
                                appStyle(28, AppColors.black, FontWeight.w400),
                          ),
                        ],
                      ),
                      Text(
                        'Whatsapp Number',
                        style: appStyle(28, AppColors.black, FontWeight.w400),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(2, 1),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Email Adress',
                            hintStyle: appStyle(
                                15, AppColors.greytext, FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.h),
                          ),
                          cursorColor: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(2, 1),
                            ),
                          ],
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: appStyle(
                                15, AppColors.greytext, FontWeight.w400),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.h),
                          ),
                          cursorColor: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => const MainPage(),
                            transition: Transition.circularReveal,
                            duration: const Duration(milliseconds: 900),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(2, 1),
                              ),
                            ],
                          ),
                          child: ReusableText(
                            text: 'Login',
                            style:
                                appStyle(18, AppColors.white, FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      text: "Didn't have an account ?",
                      style: appStyle(13, AppColors.black, FontWeight.w400),
                    ),
                    SizedBox(width: 5.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const SignUpPage(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(
                            milliseconds: 900,
                          ),
                        );
                      },
                      child: ReusableText(
                        text: "Sign up",
                        style: appStyle(13, AppColors.black, FontWeight.bold),
                      ),
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
}
