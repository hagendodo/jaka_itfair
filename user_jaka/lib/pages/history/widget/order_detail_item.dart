import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/constants/constants.dart';

class OrderDetailItem extends StatelessWidget {
  final String itemName;
  final int quantity;
  final int price;

  const OrderDetailItem({
    super.key,
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.white, // Warna border
                width: 1, // Lebar border
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style: const TextStyle(color: AppColors.white),
              ),
              Text(
                '$quantity x $price',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
