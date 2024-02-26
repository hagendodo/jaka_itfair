import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:user_jaka/pages/auth/signin_page.dart';

class OTP extends StatefulWidget {
  const OTP({super.key, required this.nim});

  final String nim;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: ReusableText(
          text: 'Verifikasi OTP',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 27.h),
                  child: ReusableText(
                    text: 'Masukkan Kode',
                    style: appStyle(30, AppColors.black, FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.h),
                  child: ReusableText(
                    text: 'Verifikasi OTP',
                    style: appStyle(30, AppColors.black, FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  keyboardType: TextInputType.number,
                  focusedBorderColor: AppColors.primary,
                  borderColor: AppColors.grey,
                  showFieldAsBox: true,
                  fieldWidth: 45.w,
                  borderRadius: BorderRadius.circular(12.h),
                  borderWidth: 2.w,
                  textStyle: appStyle(20, AppColors.black, FontWeight.bold),
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    setState(() {
                      otp = verificationCode;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.h),
                  child: Text(
                    'Kode verifikasi sudah dikirim ke Whatsapp. Ayo cek sekarang. ',
                    style: appStyle(12, AppColors.black, FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () async {
                    OTPController otpController = OTPController();
                    bool isVerified =
                        await otpController.verifyOTP(widget.nim, otp);
                    if (isVerified) {
                      Get.offAll(
                        () => const SignInPage(),
                      );
                    } else {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OTP Failed. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.h),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                      ),
                      child: ReusableText(
                        text: 'Verify',
                        style: appStyle(18, AppColors.white, FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
