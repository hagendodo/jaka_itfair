import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/history/widget/order_detail.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.orders});

  final dynamic orders;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (orders['status'] == 'active') {
          Get.to(
            () => const OrderDetail(),
            transition: Transition.cupertinoDialog,
            duration: const Duration(milliseconds: 900),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Container(
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
                )
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.h),
            child: Row(
              children: [
                Image.network(
                  "https://cdn.iconscout.com/icon/free/png-512/free-fork-and-spoon-1960305-1655191.png?f=webp&w=60",
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${orders['title']}",
                              style: appStyle(
                                15,
                                AppColors.black,
                                FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          Text(
                            "Rp ${orders['totalprice'].toString()}",
                            style:
                                appStyle(13, Colors.black54, FontWeight.normal),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          orders['status'] == 'delivered'
                              ? const Icon(
                                  Icons.check_circle_sharp,
                                  color: Colors.green,
                                )
                              : orders['status'] == 'canceled'
                                  ? const Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.directions_walk_outlined,
                                      color: AppColors.black,
                                    ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            orders['status'] == 'delivered'
                                ? 'Food Delivered'
                                : orders['status'] == 'canceled'
                                    ? 'Order Canceled'
                                    : 'Order Active',
                            style: appStyle(
                              13,
                              AppColors.grey,
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${orders['menu']}",
                        style: appStyle(13, Colors.black54, FontWeight.normal),
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
  }
}
