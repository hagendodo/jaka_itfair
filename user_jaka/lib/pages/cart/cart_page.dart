import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/carts_hooks.dart';
import 'package:user_jaka/pages/cart/widget/cart_detail.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController _cartController = CartController();
  List<dynamic>? cartItems;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchCartData() async {
    try {
      List<dynamic> cartData = await _cartController.fetchCartUser();
      if (mounted) {
        setState(() {
          cartItems = cartData;
          isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      await _cartController.deleteCartItem(cartItemId);

      await fetchCartData();
    } catch (error) {
      // print('Error deleting cart item: $error');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        title: Text(
          'My Cart',
          style: appStyle(
            23,
            AppColors.black,
            FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems == null
              ? const Center(child: Text('Cart is empty'))
              : ListView.builder(
                  itemCount: cartItems?.length,
                  itemBuilder: (context, index) {
                    final item = cartItems?[index];
                    final merchantName = item?['merchants']['name'];
                    final merchantId = item?['merchants']['id'];

                    final products = item?['products'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey.shade300,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.storefront_outlined,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(
                                        width: 7.h,
                                      ),
                                      ReusableText(
                                        text: merchantName,
                                        style: appStyle(15, AppColors.black,
                                            FontWeight.bold),
                                      ),
                                    ],
                                  ),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.90,
                                          child: ShowCart(
                                            merchantId: merchantId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 5.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(8.h),
                                      ),
                                      child: ReusableText(
                                        text: 'Checkout',
                                        style: appStyle(14, AppColors.white,
                                            FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Column(
                              children: [
                                ListTile(
                                  subtitle: Row(
                                    children: [
                                      SizedBox(
                                        width: 2.h,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                product['image'],
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                      text: product['name'],
                                                      style: appStyle(
                                                          15,
                                                          AppColors.black,
                                                          FontWeight.w500),
                                                    ),
                                                    ReusableText(
                                                      text: product['quantity']
                                                          .toString(),
                                                      style: appStyle(
                                                          15,
                                                          AppColors.black,
                                                          FontWeight.w500),
                                                    ),
                                                    ReusableText(
                                                      text:
                                                          'Rp ${product['price']}',
                                                      style: appStyle(
                                                          13,
                                                          AppColors.grey,
                                                          FontWeight.w500),
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
                                                title: const Text(
                                                    'Konfirmasi Hapus'),
                                                content: const Text(
                                                    'Anda yakin akan menghapus makanan ini dari keranjang?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteCartItem(
                                                          product['cart_id']);
                                                      Navigator.of(context)
                                                          .pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Deleted Product Successfully'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.h,
                                                              vertical: 3.h),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppColors.primary,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                      ),
                                                      child: const Text(
                                                        'Ya',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .white),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Tutup dialog
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
                                  ),
                                ),
                                Divider(
                                  color: AppColors.grey.withOpacity(0.4),
                                  thickness: 2,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:user_jaka/common/appstyle.dart';
// import 'package:user_jaka/common/custom_container.dart';
// import 'package:user_jaka/common/reusable_text.dart';
// import 'package:user_jaka/constants/constants.dart';
// import 'package:user_jaka/pages/cart/widget/cart_detail.dart';
// import 'package:user_jaka/pages/cart/widget/cart_list.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key, this.merchants});

//   final dynamic merchants;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: AppColors.white,
//         title: Text(
//           'My Cart',
//           style: appStyle(
//             23,
//             AppColors.black,
//             FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SafeArea(
//             child: CustomContainer(
//               color: Colors.grey.shade200,
//               containerContent: const CartList(),
//             ),
//           ),
//           // Positioned(
//           //   bottom: 8.h,
//           //   left: 0,
//           //   right: 0,
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: [
//           //       GestureDetector(
//           //         onTap: () {
//           //           showModalBottomSheet(
//           //             isScrollControlled: true,
//           //             shape: const RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.only(
//           //                 topRight: Radius.circular(30),
//           //                 topLeft: Radius.circular(30),
//           //               ),
//           //             ),
//           //             context: context,
//           //             builder: (context) => SizedBox(
//           //               height: MediaQuery.of(context).size.height * 0.90,
//           //               child: const ShowCart(),
//           //             ),
//           //           );
//           //         },
//           //         child: Container(
//           //           padding: EdgeInsets.symmetric(horizontal: 10.h),
//           //           child: Container(
//           //             padding: EdgeInsets.symmetric(vertical: 10.h),
//           //             width: double.infinity,
//           //             decoration: BoxDecoration(
//           //               color: AppColors.primary,
//           //               borderRadius: BorderRadius.circular(12),
//           //             ),
//           //             child: Column(
//           //               children: [
//           //                 ReusableText(
//           //                   text: 'Procced to Checkout',
//           //                   style:
//           //                       appStyle(15, AppColors.white, FontWeight.bold),
//           //                 )
//           //               ],
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }
