import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';

class ShowFood extends StatelessWidget {
  const ShowFood({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  final String image;
  final String name;
  final String price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: 250.h,
              height: 250.h,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: name,
                      style: appStyle(18, AppColors.black, FontWeight.bold),
                    ),
                    ReusableText(
                      text: "Rp$price",
                      style: appStyle(18, AppColors.primary, FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  style: appStyle(11, AppColors.grey, FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
