import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/auth_controller.dart';
import 'package:user_jaka/pages/home/home_page.dart';
import 'package:user_jaka/pages/main_page.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final String? nim = Get.arguments?['nim'];

    // Periksa jika nim null
    if (nim == null) {
      // Tampilkan pesan kesalahan jika nim null
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: NIM is null.'),
            backgroundColor: Colors.red,
          ),
        );
      });

      return Scaffold(body: Container());
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: ReusableText(
          text: 'Verification',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: OtpTextField(
              numberOfFields: 6,
              borderColor: AppColors.primary,
              focusedBorderColor: AppColors.black,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) async {
                print('NIM: $nim, OTP: $verificationCode');
                OTPController otpController = OTPController();
                bool isVerified =
                    await otpController.verifyOTP(nim!, verificationCode);
                if (isVerified) {
                  Get.to(() => const MainPage());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('OTP Failed. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
