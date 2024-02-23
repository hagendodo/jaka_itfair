import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/custom_container.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/cart/widget/cart_detail.dart';
import 'package:user_jaka/pages/cart/widget/cart_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, this.merchants});

  final dynamic merchants;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        title: Text(
          'My Cart',
          style: appStyle(
            23,
            AppColors.black,
            FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: CustomContainer(
              color: Colors.grey.shade200,
              containerContent: const CartList(),
            ),
          ),
          Positioned(
            bottom: 8.h,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ReusableText(
                            text: 'Procced to Checkout',
                            style:
                                appStyle(15, AppColors.white, FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 50.h),
      //   child: FloatingActionButton(
      //     onPressed: () => showModalBottomSheet(
      //       isScrollControlled: true,
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.only(
      //           topRight: Radius.circular(30),
      //           topLeft: Radius.circular(30),
      //         ),
      //       ),
      //       context: context,
      //       builder: (context) => SizedBox(
      //           height: MediaQuery.of(context).size.height * 0.90,
      //           child: const ShowCart()),
      //     ),
      //     backgroundColor: AppColors.primary,
      //     child: const Icon(
      //       CupertinoIcons.cart,
      //       color: AppColors.white,
      //     ),
      //   ),
      // ),
    );
  }
}
