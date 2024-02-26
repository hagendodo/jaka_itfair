import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/hooks/food_hooks.dart';
import 'package:user_jaka/hooks/merchant_hooks.dart';
import 'package:user_jaka/pages/home/widget/food_widget.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final FoodHooksController _foodHooksController = FoodHooksController();
  List<dynamic> foods = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fecthFood();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fecthFood() async {
    try {
      List<dynamic> foodlist = await _foodHooksController.fetchProduct();
      if (mounted) {
        setState(() {
          foods = foodlist;
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: DotLottieLoader.fromAsset(
              'assets/img/loading_screen.lottie',
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              },
            ),
          )
        : Container(
            height: 280.h,
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foods.length,
              itemBuilder: (context, index) {
                var food = foods[index];
                return FoodWidget(
                  onTap: () async {
                    try {
                      Map<String, dynamic>? merchant =
                          await MerchantController()
                              .fetchMerchantByFood(food['id'].toString());
                      if (merchant != null) {
                        double ratings = merchant['ratings'] != null
                            ? merchant['ratings'].toDouble()
                            : 0.0;
                        Get.to(() => MerchantPage(
                              merchantId: merchant['id'],
                              name: merchant['name'],
                              image: merchant['image_url'],
                              address: merchant['address'].toString(),
                              rating: ratings,
                            ));
                      } else {
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Merchant Tidak Ditemukan'),
                              content: const Text(
                                  'Maaf, merchant untuk makanan ini tidak ditemukan.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } catch (error) {
                      // print('Error fetching merchant details: $error');
                      return;
                    }
                  },
                  title: food['name'],
                  image: food['image'],
                  price: food['price'].toString(),
                );
              },
            ),
          );
  }
}
