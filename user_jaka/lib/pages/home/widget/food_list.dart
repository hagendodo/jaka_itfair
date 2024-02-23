import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/home/widget/food_widget.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(foods.length, (i) {
          var food = foods[i];
          return FoodWidget(
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
              image: food['imageURL'],
              title: food['title'],
              time: food['time'],
              price: food['price'].toString());
        }),
      ),
    );
  }
}
