import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/constants/uidata.dart';
import 'package:user_jaka/controller/tab_index_controller.dart';
import 'package:user_jaka/pages/cart/cart_page.dart';
import 'package:user_jaka/pages/history/history_page.dart';
import 'package:user_jaka/pages/home/home_page.dart';
import 'package:user_jaka/pages/profile/profile_page.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> pageList = [
    const HomePage(),
    const CartPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabIndexController());
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            pageList[controller.tabIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: AppColors.white),
                child: BottomNavigationBar(
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.grey,
                  onTap: (value) {
                    controller.setTabIndex = value;
                  },
                  currentIndex: controller.tabIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: controller.tabIndex == 0
                          ? const Icon(CupertinoIcons.square_grid_2x2_fill)
                          : const Icon(CupertinoIcons.square_grid_2x2),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Badge(
                        label: Text('${carts.length}'),
                        child: controller.tabIndex == 1
                            ? const Icon(CupertinoIcons.cart_fill)
                            : const Icon(CupertinoIcons.cart),
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: controller.tabIndex == 2
                          ? const Icon(Icons.library_books)
                          : const Icon(Icons.library_books_outlined),
                      label: 'History',
                    ),
                    BottomNavigationBarItem(
                      icon: controller.tabIndex == 3
                          ? const Icon(CupertinoIcons.person_crop_circle_fill)
                          : const Icon(CupertinoIcons.person_crop_circle),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
