import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/controller/cart_controller.dart';

class CartFoodMerchant extends StatefulWidget {
  const CartFoodMerchant({
    super.key,
    required this.foodId,
    required this.title,
    required this.price,
    required this.imageURL,
  });

  final int foodId;
  final String imageURL;
  final String title;
  final int price;

  @override
  State<CartFoodMerchant> createState() => _CartFoodMerchantState();
}

class _CartFoodMerchantState extends State<CartFoodMerchant> {
  final controller = Get.put(CartFoodController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox(
        //   activeColor: AppColors.primary,
        //   value: controller.isCheckbox.value,
        //   onChanged: (value) {
        //     setState(() {
        //       controller.checkBox(true);
        //     });
        //   },
        // ),
        SizedBox(
          width: 5.h,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.imageURL,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 10.h,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: widget.title,
                        style: appStyle(
                          15,
                          AppColors.black,
                          FontWeight.w500,
                        ),
                      ),
                      ReusableText(
                        text: 'Rp ${widget.price}',
                        style: appStyle(
                          13,
                          AppColors.grey,
                          FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.increment();
                            },
                            child: const Icon(
                              AntDesign.pluscircle,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(
                            width: 7.h,
                          ),
                          Obx(
                            () => ReusableText(
                              text: '${controller.count.value}',
                              style: appStyle(
                                  14, AppColors.black, FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            width: 7.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.decrement();
                            },
                            child: const Icon(
                              AntDesign.minuscircle,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Konfirmasi Hapus'),
                  content: const Text(
                      'Anda yakin akan menghapus makanan ini dari keranjang?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Tanggapan jika pengguna memilih untuk tetap menghapus
                        Navigator.of(context).pop(); // Tutup dialog
                        // Tambahkan logika untuk menghapus makanan dari keranjang di sini
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 3.h),
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            )),
                        child: const Text(
                          'Ya',
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup dialog
                      },
                      child: const Text('Tidak'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            FontAwesome.trash_o,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
