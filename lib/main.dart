// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/features/auth/controllers/auth_controller.dart';
import 'package:personal_project/features/auth/screens/login.dart';
import 'package:personal_project/features/home/screens/home_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      builder: (BuildContext context, Widget? child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ref.watch(currentUserAccountProvider).when(
              data: (user) {
                if (user != null) {
                  return const HomePage();
                }
                return const LoginPage();
              },
              error: (error, st) => Scaffold(
                body: Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
              ),
              loading: () => Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
      ),
    );
  }
}
