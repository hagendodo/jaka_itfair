import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key, required this.food});

  final dynamic food;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final merchantId = int.parse(food['merchant'].toString());
        final merchant = merchants.firstWhere(
            (merchant) => merchant['_id'] == merchantId,
            orElse: () => null);

        if (merchant != null) {
          Get.to(() => MerchantPage(merchants: merchant));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Merchant Tidak Ditemukan'),
                content: const Text(
                    'Maaf, merchant untuk makanan ini tidak ditemukan.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
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
                            food['imageURL'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: food['title'],
                        style: appStyle(11, AppColors.black, FontWeight.w400),
                      ),
                      ReusableText(
                        text: "Delivery time: ${food['time']}",
                        style: appStyle(11, AppColors.grey, FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 6.h,
            child: ReusableText(
              text: 'Rp ${food['price'].toStringAsFixed(0).replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match match) => '${match[1]}.',
                  )}',
              style: appStyle(15, AppColors.primary, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
