import 'package:flutter/material.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/merchant/widget/item_food.dart';

class MerchantFood extends StatelessWidget {
  const MerchantFood({super.key, required this.merchantId});

  final int merchantId;

  @override
  Widget build(BuildContext context) {
    final merchantFoods = foods
        .where((food) => food['merchant'] == merchantId.toString())
        .toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: merchantFoods.length,
      itemBuilder: (context, index) {
        final food = merchantFoods[index];
        return FoodItem(
          food: food,
        );
      },
    );
  }
}
