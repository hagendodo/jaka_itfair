// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:user_jaka/common/appstyle.dart';
// import 'package:user_jaka/common/reusable_text.dart';
// import 'package:user_jaka/constants/constants.dart';
// import 'package:user_jaka/constants/uidata.dart';
// import 'package:user_jaka/pages/cart/widget/cart_detail.dart';
// import 'package:user_jaka/pages/cart/widget/cart_food_list_merchant.dart';

// class CartStore extends StatefulWidget {
//   const CartStore({
//     super.key,
//     required this.cartId,
//     required this.merchantId,
//   });

//   final int cartId;

//   final int merchantId;

//   @override
//   State<CartStore> createState() => _CartStoreState();
// }

// class _CartStoreState extends State<CartStore> {
//   bool store = false;
//   String merchantName = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchMerchantName();
//   }

//   Future<void> _fetchMerchantName() async {
//     final merchant = merchants.firstWhere(
//       (merchant) => merchant['_id'] == widget.merchantId,
//       orElse: () => {},
//     );
//     if (merchant.isNotEmpty) {
//       setState(() {
//         merchantName = merchant['title'];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 3.h,
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.h),
//           decoration: const BoxDecoration(
//             color: AppColors.white,
//             border: Border(
//               bottom: BorderSide(
//                 color: AppColors.grey,
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: 8.h,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Checkbox(
//                 //   activeColor: AppColors.primary,
//                 //   value: store,
//                 //   onChanged: (value) {
//                 //     setState(() {
//                 //       store = value!;
//                 //     });
//                 //   },
//                 // ),
//                 // SizedBox(
//                 //   width: 5.h,
//                 // ),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.storefront_outlined,
//                       color: AppColors.primary,
//                     ),
//                     SizedBox(
//                       width: 7.h,
//                     ),
//                     ReusableText(
//                       text: merchantName,
//                       style: appStyle(15, AppColors.black, FontWeight.bold),
//                     ),
//                   ],
//                 ),

//                 GestureDetector(
//                   onTap: () {
//                     showModalBottomSheet(
//                       isScrollControlled: true,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(30),
//                           topLeft: Radius.circular(30),
//                         ),
//                       ),
//                       context: context,
//                       builder: (context) => SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.90,
//                         child: const ShowCart(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.h),
//                     decoration: BoxDecoration(
//                       color: AppColors.primary,
//                       borderRadius: BorderRadius.circular(8.h),
//                     ),
//                     child: ReusableText(
//                       text: 'Checkout',
//                       style: appStyle(14, AppColors.white, FontWeight.bold),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         Container(
//           color: AppColors.white,
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.h),
//           child: CartFoodListMerchant(merchantId: widget.merchantId),
//         ),
//         Container(
//           height: 3,
//           color: Colors.blue.shade100,
//         ),
//       ],
//     );
//   }
// }
