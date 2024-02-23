import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/merchant_controller.dart';
import 'package:user_jaka/pages/merchant/widget/show_food.dart';

class FoodItem extends StatefulWidget {
  const FoodItem({super.key, required this.food});

  final Map<String, dynamic> food;

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  final MerchantCart buttonController = Get.put(MerchantCart());
  bool _showButtons = true;

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
                      child: ShowFood(food: widget.food),
                    ),
                  );
                },
                child: Image.network(
                  widget.food['imageURL'],
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
                      text: widget.food['title'],
                      style: appStyle(15, AppColors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        ReusableText(
                          text: "${widget.food['ratingCount']} terjual",
                          style: appStyle(12, AppColors.grey, FontWeight.w500),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.h),
                          child: ReusableText(
                            text: '|',
                            style:
                                appStyle(12, AppColors.grey, FontWeight.w500),
                          ),
                        ),
                        ReusableText(
                          text: 'Rating: ${widget.food['rating']}',
                          style: appStyle(12, AppColors.grey, FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text:
                              "Rp ${widget.food['price'].toString().replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match match) => '${match[1]}.',
                                  )}",
                          style:
                              appStyle(15, AppColors.primary, FontWeight.w600),
                        ),
                        _showButtons
                            ? TextButton(
                                onPressed: () {
                                  buttonController.toggleButton(true);
                                  setState(() {
                                    _showButtons = false;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.h, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.primary,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ReusableText(
                                    text: 'Add',
                                    style: appStyle(
                                        14, AppColors.primary, FontWeight.bold),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        buttonController.incrementFood();
                                      });
                                    },
                                    child: const Icon(
                                      AntDesign.pluscircle,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Obx(
                                      () => ReusableText(
                                        text: buttonController.merchantFood
                                            .toString(),
                                        style: appStyle(14, AppColors.black,
                                            FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (buttonController
                                                .merchantFood.value >
                                            1) {
                                          buttonController.decrementFood();
                                        } else {
                                          buttonController.toggleButton(false);
                                          _showButtons = true;
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      AntDesign.minuscircle,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
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
