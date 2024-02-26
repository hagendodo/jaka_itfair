import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';

class PaymentMenthod extends StatefulWidget {
  const PaymentMenthod({super.key});

  @override
  State<PaymentMenthod> createState() => _PaymentMenthodState();
}

class _PaymentMenthodState extends State<PaymentMenthod> {
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
                      value: true,
                      onChanged: (value) {
                        setState(() {});
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
                        RichText(
                          text: TextSpan(
                            text: '',
                            style:
                                appStyle(15, AppColors.black, FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Cashless ',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(10.h),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 6.h),
                          child: ReusableText(
                            text: 'Soon',
                            style: appStyle(
                                12, AppColors.secondary, FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    // Checkbox(
                    //   value: paymentController.isCashlessPayment.value,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       paymentController.checkCashless(value ?? false);
                    //     });
                    //   },
                    // )
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
