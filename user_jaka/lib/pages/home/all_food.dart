import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/food_hooks.dart';
import 'package:user_jaka/pages/home/widget/food_tile.dart';

class AllFood extends StatefulWidget {
  const AllFood({super.key});

  @override
  State<AllFood> createState() => _AllFoodState();
}

class _AllFoodState extends State<AllFood> {
  final FoodHooksController _foodController = FoodHooksController();
  List<dynamic> foods = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMerchants();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchMerchants() async {
    try {
      List<dynamic> foodlist = await _foodController.fetchProduct();
      setState(() {
        foods = foodlist;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: ReusableText(
          text: 'All Food',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: foods.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child:
                  DotLottieLoader.fromAsset('assets/img/loading_screen.lottie',
                      frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              }),
            )
          : ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                var food = foods[index];
                return FoodTile(
                  foodId: food['id'],
                  name: food['name'],
                  imageURL: food['image'],
                  price: food['price'].toString(),
                );
              },
            ),
    );
  }
}
