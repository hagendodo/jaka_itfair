import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/pages/cart/widget/cart_food_list_merchant.dart';

class CartStore extends StatefulWidget {
  const CartStore({
    super.key,
    required this.cartId,
    required this.merchantId,
  });

  final int cartId;

  final int merchantId;

  @override
  State<CartStore> createState() => _CartStoreState();
}

class _CartStoreState extends State<CartStore> {
  bool store = false;
  String merchantName = '';

  @override
  void initState() {
    super.initState();
    _fetchMerchantName();
  }

  Future<void> _fetchMerchantName() async {
    final merchant = merchants.firstWhere(
      (merchant) => merchant['_id'] == widget.merchantId,
      orElse: () => {},
    );
    if (merchant.isNotEmpty) {
      setState(() {
        merchantName = merchant['title'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.h),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.grey,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: AppColors.primary,
                value: store,
                onChanged: (value) {
                  setState(() {
                    store = value!;
                  });
                },
              ),
              SizedBox(
                width: 5.h,
              ),
              const Icon(
                Icons.storefront_outlined,
                color: AppColors.primary,
              ),
              SizedBox(
                width: 7.h,
              ),
              ReusableText(
                text: merchantName,
                style: appStyle(15, AppColors.black, FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.h),
          child: CartFoodListMerchant(merchantId: widget.merchantId),
        ),
        Container(
          height: 3,
          color: Colors.blue.shade100,
        ),
      ],
    );
  }
}
