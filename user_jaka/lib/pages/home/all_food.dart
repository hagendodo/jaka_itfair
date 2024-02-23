import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/home/widget/food_tile.dart';

class AllFood extends StatelessWidget {
  const AllFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: ReusableText(
          text: 'All Food',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(
          12.h,
        ),
        child: ListView(
          children: List.generate(foods.length, (i) {
            var food = foods[i];
            return FoodTile(food: food);
          }),
        ),
      ),
    );
  }
}
