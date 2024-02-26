import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:user_jaka/pages/auth/signup_page.dart';
import 'package:user_jaka/pages/main_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController _signInController = SignInController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;
  bool isAllInputFilled() {
    return email.text.isNotEmpty && password.text.isNotEmpty;
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
                    height: MediaQuery.of(context).size.height * 0.28,
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
                              controller: email,
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
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  controller: password,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: appStyle(15, AppColors.greytext,
                                        FontWeight.w400),
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
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
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
                      )),
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
                                  Map<String, dynamic> signInResult =
                                      await _signInController.signIn(
                                          email.text, password.text);

                                  if (signInResult.isNotEmpty) {
                                    Map<String, dynamic>? userData =
                                        await _signInController.getUser();
                                    if (userData != null) {
                                      // String token = userData['token'];
                                      // Map<String, dynamic> user =
                                      //     userData['user'];
                                      // print('Token: $token');
                                      // print('User: $user');

                                      Get.offAll(() => const MainPage());
                                    } else {
                                      // print('Failed to get user data.');
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Failed to get user data.'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Sign In failed. Please try again.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  // Jika tidak semua input terisi, tampilkan pesan kesalahan
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
                                  text: 'Login',
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
