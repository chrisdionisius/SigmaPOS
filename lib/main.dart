import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/login/login_page.dart';
import 'package:sigma_pos/app/modules/product/product_page.dart';
import 'app/modules/register/register_success_page.dart';
// void main() {
//   runApp(const MyApp());
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SigmaPOS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(snapshot.data!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                  if (userSnapshot.hasData &&
                      userSnapshot.data!.data() != null) {
                    final userDoc = userSnapshot.data;
                    final user = userDoc!.data();
                    var data = jsonDecode(jsonEncode(user));
                    if (data['role'] == 'owner') {
                      return const ProductPage();
                    } else if (data['role'] == 'cashier') {
                      return const ProductPage();
                    } else {
                      return const RegisterSuccessPage(role: 'cashier');
                    }
                  } else {
                    return const Material(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
