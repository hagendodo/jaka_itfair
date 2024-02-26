import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
              'assets/img/ktm_new.png',
              fit: BoxFit.cover,
              width: 300,
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: 'Select Your Image From',
                            style:
                                appStyle(14, AppColors.black, FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.camera,
                                  color: AppColors.white,
                                ),
                                SizedBox(
                                  width: 5.h,
                                ),
                                ReusableText(
                                  text: 'Camera',
                                  style: appStyle(
                                      14, AppColors.white, FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: ReusableText(
                text: 'Upload KTM',
                style: appStyle(12, AppColors.white, FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Future _pickImageFromCamera() async {
//   final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
// }
