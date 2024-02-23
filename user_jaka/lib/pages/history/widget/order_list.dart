import 'package:flutter/material.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/history/widget/order_tile.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> activeOrders =
        orders.where((order) => order['status'] == 'active').toList();

    return ListView.builder(
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        var order = activeOrders[index];
        return OrderTile(orders: order);
      },
    );
  }
}
