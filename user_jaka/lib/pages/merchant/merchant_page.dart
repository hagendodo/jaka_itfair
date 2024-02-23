import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/merchant_controller.dart';
import 'package:user_jaka/pages/cart/widget/cart_detail.dart';
import 'package:user_jaka/pages/merchant/widget/merchant_food.dart';

class MerchantPage extends StatefulWidget {
  const MerchantPage({super.key, required this.merchants});

  final dynamic merchants;

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
                              widget.merchants['imageURL'],
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
                      text: widget.merchants['title'],
                      style: appStyle(18, AppColors.black, FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ReusableText(
                      text: widget.merchants['coords']['address'],
                      style:
                          appStyle(11, AppColors.greytext, FontWeight.normal),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: widget.merchants['rating'].toDouble(),
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
                          text: "(${widget.merchants['rating'].toString()}/5)",
                          style: appStyle(9, AppColors.grey, FontWeight.w500),
                        ),
                      ],
                    ),
                    const Divider(
                      color: AppColors.grey,
                    ),
                    MerchantFood(merchantId: widget.merchants['_id']),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => Positioned(
              bottom: 10.h,
              left: 0,
              right: 0,
              child: Visibility(
                visible: buttonController.showButton.value,
                child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        context: context,
                        builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.90,
                          child: const ShowCart(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: '1 item',
                                  style: appStyle(
                                      11, AppColors.white, FontWeight.bold),
                                ),
                                ReusableText(
                                  text: 'Mie Goreng, Bu Atih',
                                  style: appStyle(
                                      10, AppColors.white, FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ReusableText(
                                  text: '20.000',
                                  style: appStyle(
                                      14, AppColors.white, FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                const Icon(
                                  FontAwesome.shopping_bag,
                                  color: AppColors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
