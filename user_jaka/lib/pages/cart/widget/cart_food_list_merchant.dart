import 'package:flutter/material.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/cart/widget/cart_food_merchant.dart';

class CartFoodListMerchant extends StatelessWidget {
  final int merchantId;
  const CartFoodListMerchant({super.key, required this.merchantId});

  List<Map<String, dynamic>> getMerchantCarts(int merchantId) {
    return carts
        .where((cart) => cart['merchant'] == merchantId.toString())
        .toList();
  }

  Map<String, dynamic> getFoodById(int foodId) {
    return foods.firstWhere(
      (food) => food['_id'] == foodId,
      orElse: () => {'_id': '', 'title': 'Unknown Food', 'price': 0},
    );
  }

  @override
  Widget build(BuildContext context) {
    final merchantCarts = getMerchantCarts(merchantId);

    List<Widget> cartWidgets = [];
    for (int i = 0; i < merchantCarts.length; i++) {
      final cart = merchantCarts[i];
      final food = getFoodById(int.parse(cart['food']));
      cartWidgets.add(
        CartFoodMerchant(
          foodId: food['_id'],
          title: food['title'],
          price: food['price'],
          imageURL: food['imageURL'],
        ),
      );
      if (i != merchantCarts.length - 1) {
        cartWidgets.add(const Divider(
          color: Colors.grey,
          thickness: 1,
        ));
      }
    }

    return Column(
      children: cartWidgets,
    );
  }
}
