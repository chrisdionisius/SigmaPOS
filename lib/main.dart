import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/account.dart';
import 'package:sigma_pos/app/modules/login/login_page.dart';
import 'package:sigma_pos/app/modules/product/product_page.dart';
import 'package:sigma_pos/app/modules/setting/category/list_category_page.dart';
import 'app/modules/register/register_success_page.dart';
import 'app/modules/setting/cashier/list_cashier_page.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: [
        GetPage(name: '/listCashier', page: () => const ListCashierPage()),
        GetPage(name: '/listCategory', page: () => const ListCategoryPage()),
      ],
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("accounts")
                    .doc(snapshot.data!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                  if (userSnapshot.hasData &&
                      userSnapshot.data!.data() != null) {
                    final userDoc = userSnapshot.data;
                    final user = userDoc!.data();
                    Account account = Account.fromJson(
                        jsonDecode(
                          jsonEncode(user),
                        ),
                        userDoc.id);
                    if (account.role == 'owner') {
                      return const ProductPage();
                    } else if (account.role == 'cashier') {
                      return const ProductPage();
                    } else {
                      return const RegisterSuccessPage(role: 'recruit');
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
