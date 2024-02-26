import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/main_page.dart';
import 'package:user_jaka/pages/onboarding/onboarding_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Widget defaultHome = const OnBoardingScreen();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getTokenFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return buildAppWithToken(snapshot.data!);
          } else {
            return buildAppWithoutToken();
          }
        }
      },
    );
  }

  Future<String?> getTokenFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Widget buildAppWithToken(String token) {
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
          home: const MainPage(),
        );
      },
    );
  }

  Widget buildAppWithoutToken() {
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
            backgroundColor: AppColors.white,
            nextScreen: const OnBoardingScreen(),
          ),
        );
      },
    );
  }
}
