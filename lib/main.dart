import 'package:courses_app/pages/login_page.dart';
import 'package:courses_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put<UserProvider>(UserProvider());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: LoginPage());
  }
}
