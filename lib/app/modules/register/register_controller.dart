import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/account.dart';
import 'package:sigma_pos/app/data/models/store.dart';
import 'package:sigma_pos/app/modules/register/register_store_page.dart';
import 'package:sigma_pos/app/modules/register/register_success_page.dart';
import 'package:sigma_pos/app/modules/register/register_user_page.dart';

import '../../data/services/firestore_service.dart';
import '../../data/states/register_state.dart';

class RegisterController extends GetxController {
  TextEditingController storeCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();

  void checkStoreCode() async {
    Store store = await checkRegisterCode(storeCodeController.text);
    if (store.id != '') {
      RegisterState.store.value = store;
      Get.off(() => const RegisterUserPage(role: 'recruit'),
          transition: Transition.rightToLeftWithFade);
    } else {
      Get.snackbar('Error', 'Store Code is not valid');
    }
  }

  void registerUser(String role) async {
    if (await emailRegistered(emailController.text)) {
      Get.snackbar('Error', 'Email Already Registered');
      return;
    }
    if (role == 'owner') {
      RegisterState.email.value = emailController.text;
      RegisterState.password.value = passwordController.text;
      Get.to(() => const RegisterStorePage(),
          transition: Transition.rightToLeftWithFade);
    }
    if (role == 'recruit') {
      String userUid =
          await signUpWithEmail(emailController.text, passwordController.text);
      Account account = Account(
          name: emailController.text,
          role: role,
          storeUid: RegisterState.store.value.id);
      if (await addAccount(userUid, account)) {
        Get.to(() => const RegisterSuccessPage(role: 'recruit'),
            transition: Transition.rightToLeftWithFade);
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    }
  }

  bool checkInput() {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return false;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Password is required');
      return false;
    }
    if (confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'Confirm Password is required');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Password and Confirm Password is not match');
      return false;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  Future<String> registerStore() async {
    //add email ke auth
    String userUid =
        await signUpWithEmail(emailController.text, passwordController.text);

    //create store object
    RegisterState.store.value = Store(
      name: storeNameController.text,
      registerCode: generateRandomCode(),
      ownerUid: userUid,
    );

    //add store ke firestore
    String storeUid = await addStore(RegisterState.store.value);

    Account account = Account(
      name: "user",
      role: 'owner',
      storeUid: storeUid,
    );

    //add user ke firestore
    await addAccount(userUid, account);

    return 'success';
  }

  String generateRandomCode() {
    String code = '';
    for (int i = 0; i < 6; i++) {
      code += (Random().nextInt(9) + 1).toString();
    }
    return code;
  }
}
