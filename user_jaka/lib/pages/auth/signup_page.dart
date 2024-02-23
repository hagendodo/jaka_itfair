import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/auth_controller.dart';
import 'package:user_jaka/pages/auth/otp_page.dart';
import 'package:user_jaka/pages/auth/signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController _signUpController = SignUpController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  String? nim;

  bool isAllInputFilled() {
    return nim != null &&
        name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmpassword.text.isNotEmpty;
  }

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
                top: MediaQuery.of(context).size.height * 0.20,
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
                            'Sign Up',
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
                      Form(
                        child: Column(
                          children: [
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
                                onChanged: (value) {
                                  nim = value;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'NIM',
                                  hintStyle: appStyle(
                                      15, AppColors.greytext, FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15.h),
                                ),
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
                                controller: name,
                                decoration: InputDecoration(
                                  hintText: 'Full Name',
                                  hintStyle: appStyle(
                                      15, AppColors.greytext, FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15.h),
                                ),
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
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email Adress',
                                  hintStyle: appStyle(
                                      15, AppColors.greytext, FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15.h),
                                ),
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
                                controller: phone,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Whatsapp Number',
                                  hintStyle: appStyle(
                                      15, AppColors.greytext, FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15.h),
                                ),
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
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: appStyle(
                                      15, AppColors.greytext, FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15.h),
                                ),
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
                                controller: confirmpassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: appStyle(
                                      15, AppColors.greytext, FontWeight.w400),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15.h),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (isAllInputFilled()) {
                            bool success = await _signUpController.signUp(
                              nim!,
                              name.text,
                              email.text,
                              phone.text,
                              password.text,
                            );
                            if (success) {
                              Get.to(
                                () => const OTPPage(),
                                arguments: {
                                  'nim': nim,
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text('Sign up failed. Please try again.'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.red,
                            ));
                          }
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
                            text: 'Sign Up',
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
                      text: "Have an account ?",
                      style: appStyle(13, AppColors.black, FontWeight.w400),
                    ),
                    SizedBox(width: 5.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const SignInPage(),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 900),
                        );
                      },
                      child: ReusableText(
                        text: "Sign In",
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
