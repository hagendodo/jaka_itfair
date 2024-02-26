import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/history_order.dart';
import 'package:user_jaka/pages/history/widget/order_detail.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late Future<List<dynamic>> _futureOrderData;

  @override
  void initState() {
    super.initState();
    _futureOrderData = fetchOrderData();
  }

  Future<List<dynamic>> fetchOrderData() async {
    try {
      HistoryOrder historyOrder = HistoryOrder();
      List<dynamic> orderData = await historyOrder.fetchHistoryOrder();
      List<dynamic> activeOrders =
          orderData.where((order) => order['status'] == 'active').toList();
      return activeOrders;
    } catch (error) {
      throw Exception('Error fetching order data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureOrderData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          List<dynamic> activeOrders = snapshot.data!;
          return ListView.builder(
            itemCount: activeOrders.length,
            itemBuilder: (context, index) {
              dynamic order = activeOrders[index];
              List<dynamic> detailOrders = order['detail_orders'];
              return Column(
                children: detailOrders.map((detailOrder) {
                  int orderPrice = detailOrder['price'];
                  String productName = detailOrder['products']['name'];
                  String merchantName =
                      detailOrder['products']['merchants']['name'];

                  return ListTile(
                    subtitle: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const OrderDetail(),
                          transition: Transition.cupertinoDialog,
                          duration: const Duration(milliseconds: 900),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 5,
                                color: Colors.grey.withOpacity(0.8),
                                offset: const Offset(3, 3),
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 20.h),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/img/order_icons.png',
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            productName,
                                            style: appStyle(
                                              15,
                                              AppColors.black,
                                              FontWeight.bold,
                                            ),
                                            softWrap: true,
                                          ),
                                        ),
                                        Text(
                                          'Rp $orderPrice',
                                          style: appStyle(13, Colors.black54,
                                              FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.directions_walk_outlined,
                                          color: AppColors.black,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        ReusableText(
                                          text: 'Order Active',
                                          style: appStyle(13, AppColors.grey,
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    ReusableText(
                                      text: merchantName,
                                      style: appStyle(13, Colors.black54,
                                          FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          );
        }
      },
    );
  }
}



    // List<dynamic> activeOrders =
    //     orders.where((order) => order['status'] == 'active').toList();

    // return ListView.builder(
    //   itemCount: activeOrders.length,
    //   itemBuilder: (context, index) {
    //     var order = activeOrders[index];
    //     return OrderTile(orders: order);
    //   },
    // );
