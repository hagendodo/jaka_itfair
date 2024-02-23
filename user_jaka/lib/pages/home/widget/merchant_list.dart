import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/home/widget/merchant_widget.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';

class MerchantList extends StatelessWidget {
  const MerchantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(merchants.length, (i) {
          var canteen = merchants[i];
          return MerchantWidget(
              onTap: () {
                Get.to(
                  () => MerchantPage(merchants: canteen),
                );
              },
              rating: canteen['rating'].toDouble(),
              image: canteen['imageURL'],
              logo: canteen['logoURL'],
              title: canteen['title'],
              time: canteen['time'],
              ratingCount: canteen['ratingCount']);
        }),
      ),
    );
  }
}
