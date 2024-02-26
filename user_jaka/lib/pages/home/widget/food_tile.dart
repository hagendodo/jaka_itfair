import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/merchant_hooks.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';
// import 'package:user_jaka/pages/merchant/merchant_page.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    super.key,
    required this.name,
    required this.imageURL,
    required this.price,
    required this.foodId,
  });

  final String foodId;
  final String price;
  final String name;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          Map<String, dynamic>? merchant =
              await MerchantController().fetchMerchantByFood(foodId);
          if (merchant != null) {
            double ratings = merchant['ratings'] != null
                ? merchant['ratings'].toDouble()
                : 0.0;
            Get.to(() => MerchantPage(
                  merchantId: merchant['id'],
                  name: merchant['name'],
                  image: merchant['image_url'],
                  address: merchant['address'].toString(),
                  rating: ratings,
                ));
          } else {
            if (!context.mounted) return;
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
        } catch (error) {
          // print('Error fetching merchant details: $error');
          return;
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
                            imageURL,
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
                        text: name,
                        style: appStyle(14, AppColors.black, FontWeight.w400),
                      ),
                      ReusableText(
                        text: "Enakk",
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
              text: 'Rp$price',
              style: appStyle(15, AppColors.primary, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
