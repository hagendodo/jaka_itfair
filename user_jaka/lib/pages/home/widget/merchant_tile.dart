import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';

class MerchantTile extends StatelessWidget {
  const MerchantTile({super.key, required this.merchants});

  final dynamic merchants;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => MerchantPage(
            merchants: merchants,
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 70.h,
            width: width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.r),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 70.w,
                          height: 70.h,
                          child: Image.network(
                            merchants["imageURL"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   child: Container(
                        //     padding: EdgeInsets.only(left: 6.w, bottom: 2.h),
                        //     color: AppColors.grey.withOpacity(0.6),
                        //     height: 16.h,
                        //     width: width,
                        //     child: RatingBarIndicator(
                        //       rating: 5,
                        //       itemCount: 5,
                        //       itemBuilder: (context, i) => const Icon(
                        //         Icons.star,
                        //         color: AppColors.secondary,
                        //       ),
                        //       itemSize: 15.h,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: merchants['title'],
                        style: appStyle(11, AppColors.black, FontWeight.w400),
                      ),
                      ReusableText(
                        text: "Delivery time: ${merchants['time']}",
                        style: appStyle(11, AppColors.grey, FontWeight.w400),
                      ),
                      SizedBox(
                        width: width * 0.7,
                        child: Text(
                          merchants['coords']['address'],
                          overflow: TextOverflow.ellipsis,
                          style: appStyle(9, AppColors.grey, FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
