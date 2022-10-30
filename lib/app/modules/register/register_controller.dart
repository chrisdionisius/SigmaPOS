import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/register/register_success_page.dart';
import 'package:sigma_pos/app/modules/register/register_user_page.dart';

import '../../data/services/firestore_service.dart';
import '../../data/states/register_state.dart';

class RegisterController extends GetxController {
  TextEditingController storeCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void checkStoreCode() async {
    if (await checkRegisterCode(storeCodeController.text) == 'success') {
      // return 'success';
      Get.off(() => const RegisterUserPage(role: 'cashier'),
          transition: Transition.rightToLeftWithFade);
    } else {
      Get.snackbar('Error', 'Store Code is not valid');
    }
  }

  Future<void> registerUser(String role) async {
    if (await checkAvailableEmail(emailController.text) == 'success') {
      if (role == 'owner') {
        RegisterState.email.value = emailController.text;
        RegisterState.password.value = passwordController.text;
        Get.to(() => const RegisterUserPage(role: 'owner'),
            transition: Transition.rightToLeftWithFade);
      } else {
        await signUpWithEmail(emailController.text, passwordController.text);
        Get.to(() => const RegisterSuccessPage(role: 'cashier'),
            transition: Transition.rightToLeftWithFade);
      }
    } else {
      Get.snackbar('Error', 'Email Already Registered');
    }
  }
}
