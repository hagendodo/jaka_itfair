import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:user_jaka/common/appstyle.dart';
import 'package:user_jaka/constants/constants.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:user_jaka/pages/profile/widget/profile_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final SignInController fecthData = SignInController();
    return FutureBuilder<Map<String, dynamic>?>(
      future: fecthData.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Map<String, dynamic>? userData = snapshot.data;
          String name = userData?['user']['name'] ?? '';
          String nim = userData?['user']['nim'] ?? '';
          String phone = userData?['user']['phone'] ?? '';
          String email = userData?['user']['email'] ?? '';

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              elevation: 0,
              title: Text(
                'Edit Profile',
                style: appStyle(
                  15,
                  AppColors.black,
                  FontWeight.bold,
                ),
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    backgroundImage: const AssetImage(
                                        'assets/img/user_profile.jpg'),
                                    radius: 50.r,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        backgroundColor: AppColors.primary),
                                    child: Text(
                                      'Edit Photo',
                                      style: appStyle(
                                          12, AppColors.white, FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ProfileTextField(
                                    title: 'Fullname',
                                    controller:
                                        TextEditingController(text: name),
                                    cursorColor: AppColors.black,
                                  ),
                                  ProfileTextField(
                                    title: 'NIM',
                                    controller:
                                        TextEditingController(text: nim),
                                    cursorColor: AppColors.black,
                                  ),
                                  ProfileTextField(
                                    title: 'Phone Number',
                                    controller:
                                        TextEditingController(text: phone),
                                    cursorColor: AppColors.black,
                                  ),
                                  ProfileTextField(
                                    title: 'Email',
                                    controller:
                                        TextEditingController(text: email),
                                    cursorColor: AppColors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

// Future _pickImageFromGallery() async {
//   final returnImage =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
// }
