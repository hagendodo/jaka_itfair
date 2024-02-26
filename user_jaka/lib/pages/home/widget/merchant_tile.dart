import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';
// import 'package:user_jaka/pages/merchant/merchant_page.dart';

class MerchantTile extends StatelessWidget {
  const MerchantTile({
    super.key,
    required this.name,
    required this.imageURL,
    required this.address,
    required this.rating,
    required this.merchantId,
  });

  final String name;
  final String imageURL;
  final String address;
  final double rating;
  final String merchantId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => MerchantPage(
            merchantId: merchantId,
            name: name,
            address: address,
            image: imageURL,
            rating: rating,
          ),
        );
      },
      child: Container(
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
                        imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: name,
                    style: appStyle(13, AppColors.black, FontWeight.w500),
                  ),
                  ReusableText(
                    text: address,
                    style: appStyle(12, AppColors.grey, FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
