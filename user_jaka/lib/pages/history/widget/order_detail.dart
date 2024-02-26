import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/chat/chat_driver.dart';
import 'package:user_jaka/pages/history/widget/delivery_order_item.dart';
import 'package:user_jaka/pages/history/widget/order_detail_item.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: Text(
          'Order Details',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.450,
            left: 10,
            right: 10,
            child: DotLottieLoader.fromAsset('assets/img/waiting.lottie',
                frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
              if (dotlottie != null) {
                return Lottie.memory(
                  dotlottie.animations.values.single,
                );
              } else {
                return Container();
              }
            }),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.05,
            minChildSize: 0.05,
            maxChildSize: 0.55,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 20.h,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
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
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.primary,
                                backgroundImage:
                                    const AssetImage('assets/img/avatar.png'),
                                radius: 30.r,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Raden Ibnu',
                                    style: appStyle(
                                        13, AppColors.white, FontWeight.bold),
                                  ),
                                  Text(
                                    'Order ID 12889120122',
                                    style: appStyle(
                                      12,
                                      AppColors.white,
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(() => const ChatDriver());
                            },
                            icon: const Icon(
                              CupertinoIcons.envelope_circle,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Details',
                            style: appStyle(
                              15,
                              AppColors.white,
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
                              AppColors.white,
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
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(color: AppColors.white),
                              ),
                              Text(
                                'Rp 350000',
                                style: appStyle(
                                    12, AppColors.white, FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )
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
