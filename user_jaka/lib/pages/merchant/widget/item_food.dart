import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:user_jaka/hooks/carts_hooks.dart';
// import 'package:user_jaka/controller/merchant_controller.dart';
import 'package:user_jaka/pages/merchant/widget/show_food.dart';

class FoodItem extends StatefulWidget {
  const FoodItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.merchantId,
    required this.productId,
  });

  final String productId;
  final String merchantId;
  final String image;
  final String name;
  final String price;
  final String description;

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  @override
  void dispose() {
    super.dispose();
    // Tambahkan kode disposisi di sini
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.grey,
                width: 0.8,
              ),
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    context: context,
                    builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: ShowFood(
                        image: widget.image,
                        name: widget.name,
                        price: widget.price,
                        description: widget.description,
                      ),
                    ),
                  );
                },
                child: Image.network(
                  widget.image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: widget.name,
                      style: appStyle(15, AppColors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        // ReusableText(
                        //   text: "${widget.food['ratingCount']} terjual",
                        //   style: appStyle(12, AppColors.grey, FontWeight.w500),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.h),
                          child: ReusableText(
                            text: '|',
                            style:
                                appStyle(12, AppColors.grey, FontWeight.w500),
                          ),
                        ),
                        // ReusableText(
                        //   text: 'Rating: ${widget.food['rating']}',
                        //   style: appStyle(12, AppColors.grey, FontWeight.w500),
                        // ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: "Rp${widget.price}",
                          style:
                              appStyle(15, AppColors.primary, FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () async {
                            SignInController signInController =
                                SignInController();
                            Map<String, dynamic>? userData =
                                await signInController.getUser();
                            String? userId = userData?['user']['id'];

                            if (userId != null) {
                              try {
                                // print(widget.productId);
                                // print(widget.merchantId);
                                // print(userData?['user']['id']);
                                await CartController().addToCart(
                                    widget.productId, widget.merchantId);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Product added to cart'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } catch (e) {
                                // Tangani jika terjadi kesalahan saat menambahkan ke keranjang
                                print('Error adding product to cart: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Failed to add product to cart'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please log in to add product to cart'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primary, width: 1.5),
                              borderRadius: BorderRadius.circular(15.h),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 8.h),
                            child: ReusableText(
                              text: 'Add',
                              style: appStyle(
                                  15, AppColors.primary, FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
