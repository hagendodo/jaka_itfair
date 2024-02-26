import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.50,
          left: 50,
          right: 50,
          child: DotLottieLoader.fromAsset('assets/img/boardingscreen1.lottie',
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
            text: 'Gausah Kemana-mana!',
            style: appStyle(20, AppColors.black, FontWeight.bold),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.38,
          left: 50,
          right: 50,
          child: Text(
            'Dengan layanan pengiriman Jaka, Anda tak perlu repot pergi ke kantin. Hemat waktu untuk tetap di gedung perkuliahan!',
            textAlign: TextAlign.center,
            style: appStyle(13, AppColors.black, FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
