// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/controllers/auth_controller.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login({required String username, required password}) {
    final authController = ref.watch(authControllerProvider);
    authController.signIn(
      username: username.trim(),
      password: password.trim(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeightSpacer(height: 4.h),
                Center(
                  child: Image.asset(
                    AssetConstats.logoImage,
                    height: 294.h,
                    width: 294.w,
                    alignment: Alignment.topCenter,
                  ),
                ),
                HeightSpacer(height: 70.h),
                CustomText(
                  style: customStyle(size: 64),
                  text: "Welcome",
                ),
                CustomText(
                  text: "  To My App Managemnt",
                  style: customStyle(size: 16),
                ),
                HeightSpacer(height: 50),
                CustomTextFormField(
                  controller: userIdController,
                  labelText: "User ID",
                ),
                HeightSpacer(height: 12),
                CustomTextFormField(
                  controller: passwordController,
                  labelText: "Password",
                ),
                HeightSpacer(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: CustomTapText(
                    onTap: () {},
                    text: "Forgot Password?",
                    // textAlign: TextAlign.right,
                    style: customStyle(
                      size: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                HeightSpacer(height: 100),
                CustomTextButton(
                  height: 50,
                  width: double.infinity,
                  onTap: () => login(
                    username: userIdController.text,
                    password: passwordController.text,
                  ),
                  text: "Login",
                  style: customStyle(
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
