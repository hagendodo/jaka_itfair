import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/constants/constants.dart';
// import 'package:user_jaka/pages/main_page.dart';
import 'package:user_jaka/pages/onboarding/onboarding_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Widget defaultHome = const OnBoardingScreen();
void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Jaka',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            iconTheme: const IconThemeData(color: AppColors.black),
            primarySwatch: Colors.grey,
          ),
          home: AnimatedSplashScreen(
            splash: Image.asset('assets/img/jaka_icon.jpg'),
            duration: 3000,
            splashTransition: SplashTransition.sizeTransition,
            backgroundColor: AppColors.white,
            nextScreen: defaultHome,
          ),
        );
      },
    );
  }
}
