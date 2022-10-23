import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/login/login_page.dart';
import 'package:sigma_pos/app/modules/product/product_page.dart';

import 'app/data/models/store.dart';
import 'app/data/services/firestore_service.dart';
import 'app/modules/sales_report/sales_report_page.dart';

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
            // lek ditambahi async ga gelem
            if (snapshot.hasData) {
              // Store store = await readStore(); // await e error
              // if (store.id == null) {
              //   return const SalesReportPage();
              // }
              return const ProductPage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
