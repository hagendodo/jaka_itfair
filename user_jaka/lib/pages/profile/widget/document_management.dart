import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/common/reusable_text.dart';
import 'package:user_jaka/constants/constants.dart';

class DocumentManagement extends StatelessWidget {
  const DocumentManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        title: ReusableText(
          text: 'My Document',
          style: appStyle(15, AppColors.black, FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Done',
              style: appStyle(
                13,
                AppColors.primary,
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      text: 'Kartu Tanda Mahasiswa',
                      style: appStyle(
                        16,
                        AppColors.grey,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColors.grey,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Ionicons.person,
                              size: 100.h,
                              color: AppColors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 9,
                            width: 180,
                            decoration: const BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 9,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45.h,
                          ),
                          Container(
                            height: 9,
                            width: 130,
                            decoration: const BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 9,
                            width: 150,
                            decoration: const BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
