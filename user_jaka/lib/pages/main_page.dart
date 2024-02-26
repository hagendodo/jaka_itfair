import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/cart/cart_page.dart';
import 'package:user_jaka/pages/history/history_page.dart';
import 'package:user_jaka/pages/home/home_page.dart';
import 'package:user_jaka/pages/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> _children;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _children = const [HomePage(), CartPage(), HistoryPage(), ProfilePage()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const Icon(CupertinoIcons.square_grid_2x2_fill)
                : const Icon(
                    CupertinoIcons.square_grid_2x2,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(CupertinoIcons.cart_fill)
                : const Icon(CupertinoIcons.cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(Icons.library_books)
                : const Icon(Icons.library_books_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(CupertinoIcons.person_crop_circle_fill)
                : const Icon(CupertinoIcons.person_crop_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black38,
      ),
    );
  }
}
