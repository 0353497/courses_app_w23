import 'package:courses_app/pages/login_page.dart';
import 'package:courses_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/utils.dart';

void main() {
  runApp(const MainApp());
  Get.put<UserProvider>(UserProvider());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: LoginPage());
  }
}
