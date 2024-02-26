import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/merchant_controller.dart';
import 'package:user_jaka/pages/merchant/widget/merchant_food.dart';

class MerchantPage extends StatefulWidget {
  const MerchantPage({
    super.key,
    required this.merchantId,
    required this.name,
    required this.image,
    required this.address,
    required this.rating,
  });

  final String name;
  final String image;
  final String address;
  final double rating;
  final String merchantId;

  @override
  State<MerchantPage> createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  final MerchantCart buttonController = Get.put(MerchantCart());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              ClipRRect(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 230.h,
                      child: PageView.builder(
                        itemCount: 1,
                        itemBuilder: (context, i) {
                          return Container(
                            width: width,
                            height: 230.h,
                            color: AppColors.white,
                            child: Image.network(
                              widget.image,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      left: 12.w,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Ionicons.chevron_back_circle,
                          color: AppColors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ReusableText(
                      text: widget.name,
                      style: appStyle(18, AppColors.black, FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ReusableText(
                      text: widget.address,
                      style:
                          appStyle(11, AppColors.greytext, FontWeight.normal),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: widget.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: AppColors.primary,
                          ),
                          itemCount: 5,
                          itemSize: 15.h,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                          text: "${widget.rating.toString()}/5.0",
                          style: appStyle(9, AppColors.grey, FontWeight.w500),
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.grey,
                    ),
                    MerchantFood(merchantId: widget.merchantId),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
