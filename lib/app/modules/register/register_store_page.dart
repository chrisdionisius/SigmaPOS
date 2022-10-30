import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/register/register_success_page.dart';
import 'package:sigma_pos/app/widget/main_button.dart';

import '../../widget/main_textfield.dart';

class RegisterStorePage extends StatelessWidget {
  const RegisterStorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const MainTextField(hint: 'Store Name'),
                    const SizedBox(height: 20),
                    MainButton(
                      label: 'REGISTER',
                      onPressed: () => Get.off(
                          () => const RegisterSuccessPage(role: 'owner'),
                          transition: Transition.rightToLeftWithFade),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MainButton(
                label: 'BACK',
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
