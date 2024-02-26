import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/hooks/merchant_food_hooks.dart';
import 'package:user_jaka/pages/merchant/widget/item_food.dart';

class MerchantFood extends StatefulWidget {
  const MerchantFood({super.key, required this.merchantId});

  final String merchantId;

  @override
  State<MerchantFood> createState() => _MerchantFoodState();
}

class _MerchantFoodState extends State<MerchantFood> {
  List<dynamic> merchantFoods = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMerchantFoods();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchMerchantFoods() async {
    try {
      List<dynamic> foods =
          await MerchantFoodController().fetchFoodMerchant(widget.merchantId);
      if (mounted) {
        setState(() {
          merchantFoods = foods;
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
        ? Center(
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
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: merchantFoods.length,
            itemBuilder: (context, index) {
              final food = merchantFoods[index];
              return FoodItem(
                merchantId: food['merchant_id'].toString(),
                productId: food['id'].toString(),
                image: food['image'],
                name: food['name'],
                price: food['price'].toString(),
                description: food['description'].toString(),
              );
            },
          );
  }
}
