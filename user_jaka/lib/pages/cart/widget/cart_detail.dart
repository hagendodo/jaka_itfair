import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/cart_controller.dart';
import 'package:user_jaka/pages/cart/widget/cart_detail_search.dart';
import 'package:user_jaka/pages/cart/widget/payment_method.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({
    super.key,
  });

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  final controller = Get.put(ShowCartController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.only(
                  top: 15.h,
                  bottom: 5.h,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: 'Delivery Location',
                          style: appStyle(11, AppColors.grey, FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        ReusableText(
                          text: 'Gg. Al Khairat 6',
                          style: appStyle(14, AppColors.black, FontWeight.w700),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ReusableText(
                        text: "Change location",
                        style: appStyle(12, AppColors.primary, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Divider(
                color: AppColors.grey,
                height: 3.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "Mie Goreng",
                          style: appStyle(15, AppColors.black, FontWeight.bold),
                        ),
                        ReusableText(
                          text: "Rp 50000",
                          style: appStyle(13, AppColors.grey, FontWeight.w600),
                        ),
                      ],
                    ),
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/330px-Pizza-3007395.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.increment();
                          },
                          child: const Icon(
                            AntDesign.pluscircle,
                            color: AppColors.primary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Obx(
                            () => ReusableText(
                              text: '${controller.count.value}',
                              style: appStyle(
                                  14, AppColors.black, FontWeight.w600),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.decrement();
                          },
                          child: const Icon(
                            AntDesign.minuscircle,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Divider(
                color: AppColors.black,
                height: 3.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 10.h, horizontal: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: 'Payment summary',
                        style: appStyle(14, AppColors.black, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Price',
                            style: appStyle(
                              13,
                              AppColors.grey,
                              FontWeight.w500,
                            ),
                          ),
                          ReusableText(
                            text: '6000',
                            style: appStyle(
                              13,
                              AppColors.grey,
                              FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Handling and delivery fee',
                            style: appStyle(
                              13,
                              AppColors.grey,
                              FontWeight.w500,
                            ),
                          ),
                          ReusableText(
                            text: '2000',
                            style: appStyle(
                              13,
                              AppColors.grey,
                              FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Other fee(s)',
                            style: appStyle(
                              13,
                              AppColors.grey,
                              FontWeight.w500,
                            ),
                          ),
                          ReusableText(
                            text: '4000',
                            style: appStyle(
                              13,
                              AppColors.grey,
                              FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(
                        color: AppColors.black,
                        height: 2.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                              text: 'Total Payment',
                              style: appStyle(
                                  14, AppColors.black, FontWeight.bold),
                            ),
                            ReusableText(
                              text: '27.500',
                              style: appStyle(
                                  14, AppColors.black, FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bagian "Metode Pembayaran"
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Metode Pembayaran',
                      style: appStyle(12, AppColors.grey, FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                        ),
                        context: context,
                        builder: (context) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.28,
                          child: const PaymentMenthod(),
                        ),
                      ),
                      child: const Icon(Icons.more_horiz),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const CartDetailSearch(),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ReusableText(
                          text: 'Place delivery order',
                          style: appStyle(15, AppColors.white, FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
