import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/auth/signin_page.dart';
import 'package:user_jaka/pages/onboarding/intro_page_1.dart';
import 'package:user_jaka/pages/onboarding/intro_page_2.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Controller
  final PageController _controller = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            // physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
            ],
          ),

          // Dot Indicator
          Container(
            alignment: const Alignment(0, 0.75),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 2,
              effect: WormEffect(
                activeDotColor: AppColors.primary,
                dotWidth: 10.h,
                dotHeight: 10.h,
              ),
            ),
          ),

          // Continue Button
          Positioned(
            bottom: 10.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.h,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPageIndex == 0) {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  } else {
                    Get.to(
                      () => const SignInPage(),
                      transition: Transition.size,
                      duration: const Duration(milliseconds: 1000),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: appStyle(15, AppColors.white, FontWeight.bold),
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  _currentPageIndex == 0 ? 'Continue' : 'Getting Started',
                  style: appStyle(16, AppColors.white, FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
