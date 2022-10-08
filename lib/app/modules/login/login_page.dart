import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/login/login_controller.dart';
import 'package:sigma_pos/app/modules/product/product_page.dart';
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
              Obx(
                () => PasswordTextfield(
                  controller: controller.passwordController,
                  isHidden: controller.isHidden.value,
                  onPressed: () {
                    controller.isHidden.value = !controller.isHidden.value;
                  },
                ),
              ),
              const SizedBox(height: 20),
              MainButton(
                label: 'Login',
                onPressed: () => Get.to(
                  () => const ProductPage(),
                ),
              ),
              // const SizedBox(height: 10),
              // MainButton(
              //   label: 'Daftar',
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
