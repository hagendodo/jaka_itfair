import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/payment_method_controller.dart';

class PaymentMenthod extends StatefulWidget {
  const PaymentMenthod({super.key});

  @override
  State<PaymentMenthod> createState() => _PaymentMenthodState();
}

class _PaymentMenthodState extends State<PaymentMenthod> {
  final paymentController = Get.put((PaymentController()));
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            margin: EdgeInsets.only(top: 15.h, bottom: 5.h),
            decoration: const BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: 'Select a Payment Method',
                  style: appStyle(17, AppColors.black, FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar_circle_fill,
                          color: AppColors.primary,
                          size: 40.h,
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        ReusableText(
                          text: 'Cash',
                          style: appStyle(15, AppColors.black, FontWeight.bold),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: paymentController.isCashPayment.value,
                      onChanged: (value) {
                        setState(() {
                          paymentController.checkCash(value ?? false);
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: AppColors.black,
                  height: 3.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.payment_outlined,
                          color: AppColors.primary,
                          size: 40.h,
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        ReusableText(
                          text: 'Cashless',
                          style: appStyle(15, AppColors.black, FontWeight.bold),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: paymentController.isCashlessPayment.value,
                      onChanged: (value) {
                        setState(() {
                          paymentController.checkCashless(value ?? false);
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
