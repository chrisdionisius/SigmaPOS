import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/register/register_controller.dart';
import 'package:sigma_pos/app/widget/main_button.dart';

import '../../widget/main_textfield.dart';

class StoreCodePage extends StatelessWidget {
  const StoreCodePage({Key? key}) : super(key: key);

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
                      hint: 'Store Codes',
                      controller: controller.storeCodeController,
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      label: 'REGISTER',
                      onPressed: () async {
                        controller.checkStoreCode();
                      },
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
