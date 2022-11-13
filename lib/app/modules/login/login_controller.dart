import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/states/account_state.dart';

import '../../data/services/firestore_service.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isHidden = true.obs;

  void signIn() async {
    var response = await signInWithEmail(
      usernameController.text,
      passwordController.text,
    );
    if (response != 'success') {
      Get.snackbar('Error', response.toString());
    }
    AccountState.account.value = await getCurrentAccount();
    debugPrint(AccountState.account.value.name);
  }
}
