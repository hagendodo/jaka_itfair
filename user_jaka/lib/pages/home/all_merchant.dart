import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/merchant_hooks.dart';
import 'package:user_jaka/pages/home/widget/merchant_tile.dart';

class AllMerchant extends StatefulWidget {
  const AllMerchant({super.key});

  @override
  _AllMerchantState createState() => _AllMerchantState();
}

class _AllMerchantState extends State<AllMerchant> {
  final MerchantController _merchantController = MerchantController();
  List<dynamic> merchants = [];
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
      List<dynamic> merchantList = await _merchantController.fetchMerchant();
      setState(() {
        merchants = merchantList;
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
          text: 'All Merchant',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: merchants.isEmpty
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
              itemCount: merchants.length,
              itemBuilder: (context, index) {
                var merchant = merchants[index];
                double ratings = merchant['ratings'] != null
                    ? merchant['ratings'].toDouble()
                    : 0.0;
                return MerchantTile(
                  merchantId: merchant['id'],
                  name: merchant['name'],
                  imageURL: merchant['image_url'],
                  address: merchant['address'].toString(),
                  rating: ratings,
                );
              },
            ),
    );
  }
}
