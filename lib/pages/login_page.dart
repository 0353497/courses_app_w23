import 'package:courses_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool enableSignin = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "VierToreGym Courses",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Image.asset("assets/Icon.png", width: 100),
                TextFormField(
                  controller: nameController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        enableSignin = true;
                      });
                    }
                  },
                  decoration: InputDecoration(label: Text("Username")),
                ),
                TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        enableSignin = true;
                      });
                    }
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(label: Text("Password")),
                ),
                ElevatedButton(
                  onPressed: enableSignin
                      ? () {
                          Get.to(() => MainPage());
                        }
                      : null,
                  child: Text("Sign in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
