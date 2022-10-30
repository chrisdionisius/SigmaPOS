import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/widget/main_button.dart';
import 'package:sigma_pos/app/widget/password_textfield.dart';

import '../../widget/main_textfield.dart';
import 'register_controller.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/sigma.png'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainTextField(
                      hint: 'Email',
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 20),
                    PasswordTextfield(
                      controller: controller.passwordController,
                    ),
                    const SizedBox(height: 20),
                    PasswordTextfield(
                      controller: controller.confirmPasswordController,
                      hint: 'Confirm Password',
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      label: 'REGISTERs',
                      onPressed: () async {
                        await controller.registerUser(role);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomSheet: Container(
      //   // padding: const EdgeInsets.all(20),
      //   width: double.infinity,
      //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      //   child: MainButton(
      //     label: 'BACK',
      //     onPressed: () => Get.back(),
      //   ),
      // ),
    );
  }
}
