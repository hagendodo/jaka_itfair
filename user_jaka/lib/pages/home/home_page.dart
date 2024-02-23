import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/custom_container.dart';
import 'package:user_jaka/common/custom_text_field.dart';
import 'package:user_jaka/common/heading.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/home/all_food.dart';
import 'package:user_jaka/pages/home/all_merchant.dart';
import 'package:user_jaka/pages/home/widget/merchant_list.dart';
import 'package:user_jaka/pages/home/widget/food_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(130.h),
      //   child: const CustomAppbar(),
      // ),
      appBar: AppBar(
        toolbarHeight: 74.h,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        title: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: CustomTextWidget(
            controller: _searchController,
            keyboardType: TextInputType.text,
            hintText: "Search for Foods..",
            suffixIcon: GestureDetector(
              onTap: () {},
              child: Icon(
                CupertinoIcons.search_circle_fill,
                size: 40.h,
                color: AppColors.primary,
              ),
            ),
            cursorColor: AppColors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          color: AppColors.white,
          containerContent: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Heading(
                text: "Merchant",
                onTap: () {
                  Get.to(
                    () => const AllKantin(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 900),
                  );
                },
              ),
              const MerchantList(),
              SizedBox(
                height: 10.h,
              ),
              Heading(
                text: "Food",
                onTap: () {
                  Get.to(
                    () => const AllFood(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 900),
                  );
                },
              ),
              const FoodList(),
            ],
          ),
        ),
      ),
    );
  }
}
