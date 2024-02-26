import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_jaka/hooks/merchant_hooks.dart';
import 'package:user_jaka/pages/home/widget/merchant_widget.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:user_jaka/pages/merchant/merchant_page.dart';

class MerchantList extends StatefulWidget {
  const MerchantList({super.key});

  @override
  State<MerchantList> createState() => _MerchantListState();
}

class _MerchantListState extends State<MerchantList> {
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
      if (mounted) {
        setState(() {
          merchants = merchantList;
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
              itemCount: merchants.length,
              itemBuilder: (context, index) {
                var merchant = merchants[index];
                double ratings = merchant['ratings'] != null
                    ? merchant['ratings'].toDouble()
                    : 0.0;
                int ratingCount = merchant['total_ratings'] != null
                    ? int.tryParse(merchant['total_ratings'].toString()) ?? 0
                    : 0;

                return MerchantWidget(
                  onTap: () {
                    Get.to(
                      () => MerchantPage(
                        merchantId: merchant['id'],
                        name: merchant['name'],
                        image: merchant['image_url'],
                        address: merchant['address'].toString(),
                        rating: ratings,
                      ),
                    );
                  },
                  image: merchant['image_url'].toString(),
                  name: merchant['name'],
                  rating: ratings,
                  ratingCount: ratingCount.toString(),
                  address: merchant['address'].toString(),
                );
              },
            ),
          );
  }
}
