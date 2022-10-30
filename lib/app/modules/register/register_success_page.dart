import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/services/firestore_service.dart';
import 'package:sigma_pos/app/modules/login/login_page.dart';
import 'package:sigma_pos/app/widget/main_button.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({Key? key, required this.role}) : super(key: key);
  final String role;

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
                    Text(
                      (role == 'owner')
                          ? 'Store Successfully Registered'
                          : 'User Successfully Registered',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: (role == 'owner')
                          ? Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 70,
                                color: Colors.white,
                              ))
                          : const Text(
                              'Waiting For Approval',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      label: (role == 'owner') ? 'LOGIN' : 'LOGOUT',
                      onPressed: () async {
                        (role == 'owner')
                            ? Get.offAll(() => const LoginPage())
                            : await signOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
