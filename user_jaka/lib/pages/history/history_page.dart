import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/pages/history/widget/history_list.dart';
import 'package:user_jaka/pages/history/widget/order_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Orders',
            style: appStyle(
              23,
              AppColors.black,
              FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(
                child: SizedBox(
                  child: Center(
                    child: Text(
                      'On Going',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  height: 30.h,
                  child: Center(
                    child: Text(
                      'History',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderList(),
            HistoryList(),
          ],
        ),
      ),
    );
  }
}
