import 'package:flutter/material.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/history/widget/order_tile.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter pesanan dengan status 'active'
    List<dynamic> historyOrder = orders
        .where((order) =>
            order['status'] == 'canceled' || order['status'] == 'delivered')
        .toList();

    return ListView.builder(
      itemCount: historyOrder.length,
      itemBuilder: (context, index) {
        var order = historyOrder[index];
        return OrderTile(orders: order);
      },
    );
  }
}
