import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/cart/widget/cart_store.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedCarts = {};

    Set<String> uniqueMerchantIds =
        Set<String>.from(carts.map((cart) => cart['merchant']));

    for (var cart in carts) {
      final merchantId = cart['merchant'];
      if (groupedCarts.containsKey(merchantId)) {
        groupedCarts[merchantId]!.add(cart);
      } else {
        groupedCarts[merchantId] = [cart];
      }
    }

    if (groupedCarts.isEmpty) {
      return const Center(
        child: Text('No items in the cart'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: uniqueMerchantIds.map((merchantId) {
          final merchantCarts = groupedCarts[merchantId]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartStore(
                cartId: merchantCarts.first['_id'],
                merchantId: int.parse(merchantId),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
