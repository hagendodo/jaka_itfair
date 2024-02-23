import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/history/widget/delivery_order_item.dart';
import 'package:user_jaka/pages/history/widget/order_detail_item.dart';

class CartDetailSearch extends StatelessWidget {
  const CartDetailSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.cancel),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                color: AppColors.white,
                padding: EdgeInsets.only(
                  top: 10.h,
                  left: 20.h,
                  bottom: 20.h,
                  right: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: 'Preparing your order...',
                      style: appStyle(20, AppColors.black, FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: 'Arriving at',
                          style: appStyle(15, AppColors.black, FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        ReusableText(
                          text: '10:15',
                          style: appStyle(15, AppColors.black, FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 8,
                          width: MediaQuery.of(context).size.width * 0.22,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: MediaQuery.of(context).size.width * 0.22,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: MediaQuery.of(context).size.width * 0.22,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: MediaQuery.of(context).size.width * 0.22,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: 'Latest arrival by 10:40',
                          style: appStyle(15, AppColors.black, FontWeight.w400),
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        const Icon(
                          CupertinoIcons.info_circle_fill,
                          size: 20,
                          color: AppColors.grey,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 3.h,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
                child: DotLottieLoader.fromAsset('assets/img/animation.lottie',
                    frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                  if (dotlottie != null) {
                    return Lottie.memory(dotlottie.animations.values.single);
                  } else {
                    return Container();
                  }
                }),
              )
            ],
          ),
          DraggableScrollableSheet(
            snap: true,
            snapSizes: const [0.4],
            snapAnimationDuration: const Duration(milliseconds: 300),
            initialChildSize: 0.4,
            minChildSize: 0.05,
            maxChildSize: 0.42,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 45,
                        margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                        decoration: const BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Details',
                            style: appStyle(
                              15,
                              AppColors.black,
                              FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DeliveryOrderItem(
                                title: 'Address',
                                content: 'Fakultas Sains dan Teknologi',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DeliveryOrderItem(
                                title: 'Notes',
                                content:
                                    'Jangan Lupa Bang Saya ada Di bawah pohon Tugu Kujang',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            'Order',
                            style: appStyle(
                              15,
                              AppColors.black,
                              FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Column(
                            children: [
                              OrderDetailItem(
                                itemName: 'Mie Goreng',
                                quantity: 2,
                                price: 10000,
                              ),
                              OrderDetailItem(
                                itemName: 'Es Teh Manis',
                                quantity: 3,
                                price: 5000,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
