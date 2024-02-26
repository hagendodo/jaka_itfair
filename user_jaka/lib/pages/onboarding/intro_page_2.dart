import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 70.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.50,
            left: 50,
            right: 50,
            child:
                DotLottieLoader.fromAsset('assets/img/boardingscreen2.lottie',
                    frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
              if (dotlottie != null) {
                return Lottie.memory(
                  dotlottie.animations.values.single,
                );
              } else {
                return Container();
              }
            }),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.46,
            child: ReusableText(
              text: 'Telusuri, Pesan, Nikmati!',
              style: appStyle(20, AppColors.black, FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.35,
            left: 50,
            right: 50,
            child: Text(
              'Dengan sekali sentuhan jari, akses beragam hidangan lezat dari ribuan restoran favoritmu. Mulai jelajahi sekarang dan temukan cita rasa baru!',
              textAlign: TextAlign.center,
              style: appStyle(13, AppColors.black, FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
