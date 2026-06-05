import 'package:courses_app/pages/main_page.dart';
import 'package:courses_app/providers/user_provider.dart';
import 'package:courses_app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      ? () async {
                          final data = await HttpService.login(
                            nameController.value.text,
                            passwordController.value.text,
                          );
                          if (data["succes"]) {
                            final UserProvider provider =
                                Get.find<UserProvider>();
                            provider.token.value = data["result"]["token"];
                            provider.username.value = nameController.value.text;
                          }
                        }
                      : null,
                  child: Text("Sign in"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            nameController.value = TextEditingValue(text: "victoria");
            passwordController.value = TextEditingValue(text: "2cquf");
          });
        },
      ),
    );
  }
}
