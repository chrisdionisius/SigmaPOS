import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/login/login_controller.dart';
import 'package:sigma_pos/app/modules/register/register_page.dart';
import 'package:sigma_pos/app/widget/main_textfield.dart';
import 'package:sigma_pos/app/widget/password_textfield.dart';

import '../../widget/main_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(Object context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset('assets/images/sigma.png'),
              const SizedBox(height: 40),
              MainTextField(
                  controller: controller.usernameController, hint: 'Username'),
              const SizedBox(height: 20),
              PasswordTextfield(
                controller: controller.passwordController,
              ),
              const SizedBox(height: 20),
              MainButton(
                label: 'Login',
                onPressed: () => controller.signIn(),
              ),
              InkWell(
                onTap: (() {
                  Get.to(
                    () => const RegisterPage(),
                  );
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
