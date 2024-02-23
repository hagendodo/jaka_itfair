import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.carts});

  final dynamic carts;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  bool isCheked = false;
  int jumlah = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h),
        child: Row(
          children: [
            Checkbox(
              value: isCheked,
              onChanged: (value) {
                setState(() {
                  isCheked = value!;
                });
              },
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: ClipOval(
                child: Image.network(
                  'https://cdn.iconscout.com/icon/premium/png-512-thumb/snack-18-811761.png?f=webp&w=120',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.carts['title']}',
                        style: appStyle(
                          14,
                          AppColors.black,
                          FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                      Text(
                        'Rp ${widget.carts['price'] * jumlah}',
                        style: appStyle(
                          12,
                          AppColors.grey,
                          FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            jumlah++;
                          });
                        },
                        icon: const Icon(
                          AntDesign.pluscircle,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        '$jumlah',
                        style: appStyle(15, Colors.black87, FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (jumlah > 1) {
                              jumlah--;
                            }
                          });
                        },
                        icon: const Icon(
                          AntDesign.minuscircle,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
