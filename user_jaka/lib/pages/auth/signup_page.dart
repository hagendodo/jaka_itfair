import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:user_jaka/pages/auth/otp.dart';

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
  final TextEditingController nim = TextEditingController();

  bool _obscureTextPass = true;
  bool _obscureTextConfirmPass = true;
  bool isLoading = false;

  bool isAllInputFilled() {
    return nim.text.isNotEmpty &&
        name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmpassword.text.isNotEmpty;
  }

  bool isPasswordMatch() {
    return password.text == confirmpassword.text;
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
                    height: MediaQuery.of(context).size.height * 0.25,
                    color: AppColors.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/img/auth_bg.png'),
                      ],
                    ),
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
                                controller: nim,
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
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextField(
                                    controller: password,
                                    obscureText: _obscureTextPass,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: appStyle(15,
                                          AppColors.greytext, FontWeight.w400),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15.h, right: 50.h),
                                    ),
                                    cursorColor: AppColors.black,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.h),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureTextPass = !_obscureTextPass;
                                        });
                                      },
                                      icon: Icon(
                                        _obscureTextPass
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ),
                                ],
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
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextField(
                                    controller: confirmpassword,
                                    obscureText: _obscureTextConfirmPass,
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
                                      hintStyle: appStyle(15,
                                          AppColors.greytext, FontWeight.w400),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15.h, right: 50.h),
                                    ),
                                    cursorColor: AppColors.black,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.h),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureTextConfirmPass =
                                              !_obscureTextConfirmPass;
                                        });
                                      },
                                      icon: Icon(
                                        _obscureTextConfirmPass
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      GestureDetector(
                        onTap: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });

                                if (isAllInputFilled()) {
                                  if (isPasswordMatch()) {
                                    bool success =
                                        await _signUpController.signUp(
                                      nim.text,
                                      name.text,
                                      email.text,
                                      phone.text,
                                      password.text,
                                    );
                                    if (success) {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      final String? nim =
                                          prefs.getString('nim');
                                      if (nim != null) {
                                        Get.to(
                                          () => OTP(nim: nim),
                                        );
                                      } else {
                                        // print('gagal');
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Gagal'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Sign up failed. Please try again.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Passwords do not match.'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill in all fields'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isLoading ? Colors.grey : AppColors.primary,
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
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                              : ReusableText(
                                  text: 'Sign Up',
                                  style: appStyle(
                                      18, AppColors.white, FontWeight.bold),
                                ),
                        ),
                      ),
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
