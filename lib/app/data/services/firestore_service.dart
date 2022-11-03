import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigma_pos/app/data/models/order.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/store.dart';

Future signInWithEmail(email, password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return 'success';
  } catch (e) {
    return e;
  }
}

Future<String> signUpWithEmail(String email, String password) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return result.user!.uid;
  } catch (e) {
    return 'failed';
  }
}

Future<String> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return 'success';
  } catch (e) {
    return 'failed';
  }
}

Future resetPassword(email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return 'success';
  } catch (e) {
    return e;
  }
}

Future getCurrentUser() async {
  try {
    return FirebaseAuth.instance.currentUser;
  } catch (e) {
    return e;
  }
}

Future<String> getUserStore() async {
  try {
    final user = await getCurrentUser();
    final store = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    return store.data()!['store_uid'];
  } catch (e) {
    return 'failed';
  }
}

Future<Store> readStore() async {
  try {
    // final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
    //     .collection('stores')
    //     .where('owner_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((value) => value.docs.first);
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('stores')
        .doc(await getUserStore())
        .get();
    return Store.fromJson(
        jsonDecode(jsonEncode(documentSnapshot.data())), documentSnapshot.id);
  } catch (e) {
    return Store();
  }
}

//read categories and product
Future<List<Category>> readCategoriesAndProducts(String id) async {
  Query categoriesQuery = FirebaseFirestore.instance
      .collection("stores/$id/categories")
      .orderBy('name');
  QuerySnapshot categoriesQuerySnapshot = await categoriesQuery.get();
  List<Category> categoriesList = [];
  for (var document in categoriesQuerySnapshot.docs) {
    Query productsQuery = FirebaseFirestore.instance
        .collection("stores/$id/categories/${document.id}/products")
        .orderBy('name');
    QuerySnapshot productsQuerySnapshot = await productsQuery.get();
    List<Product> productsList = [];
    for (var prductDocument in productsQuerySnapshot.docs) {
      productsList.add(
        Product.fromJson(
            jsonDecode(jsonEncode(prductDocument.data())), prductDocument.id),
      );
    }
    categoriesList.add(
      Category(
        id: document.id,
        name: jsonDecode(jsonEncode(document.data()))['name'],
        products: productsList,
      ),
    );
  }
  return categoriesList;
}

//send data order to firestore
Future<void> sendOrder(Order order) async {
  //get store id
  final Store store = await readStore();
  //send order
  await FirebaseFirestore.instance
      .collection('stores/${store.id}/orders')
      .add(order.toJson());
}

//read orders
Future<List<Order>> getOrders() async {
  //get store id
  final Store store = await readStore();
  //read orders
  Query ordersQuery = FirebaseFirestore.instance
      .collection("stores/${store.id}/orders")
      .orderBy('date', descending: true);
  QuerySnapshot ordersQuerySnapshot = await ordersQuery.get();
  List<Order> ordersList = [];
  for (var document in ordersQuerySnapshot.docs) {
    ordersList.add(
      Order.fromJson(jsonDecode(jsonEncode(document.data())), document.id),
    );
  }
  return ordersList;
}

// get order today
Future<List<Order>> getOrdersToday() async {
  //get store id
  final Store store = await readStore();
  //read orders
  Query ordersQuery = FirebaseFirestore.instance
      .collection("stores/${store.id}/orders")
      .where('date', isGreaterThanOrEqualTo: DateTime.now().toString())
      .orderBy('date', descending: true);
  QuerySnapshot ordersQuerySnapshot = await ordersQuery.get();
  List<Order> ordersList = [];
  for (var document in ordersQuerySnapshot.docs) {
    ordersList.add(
      Order.fromJson(jsonDecode(jsonEncode(document.data())), document.id),
    );
  }
  return ordersList;
}

Future<bool> emailRegistered(String email) async {
  try {
    List<String> userAvail =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (userAvail.isEmpty) {
      return false;
    } else {
      return true;
    }
  } catch (e) {
    return true;
  }
}

Future<Store> checkRegisterCode(String code) async {
  try {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('stores')
        .where('register_code', isEqualTo: code)
        .get()
        .then((value) => value.docs.first);
    if (documentSnapshot.exists) {
      return Store.fromJson(
          jsonDecode(jsonEncode(documentSnapshot.data())), documentSnapshot.id);
    } else {
      return Store();
    }
  } catch (e) {
    return Store();
  }
}

Future<bool> addUser(String userUid, String storeUid, String role) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'role': role,
      'store_uid': storeUid,
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<String> addStore(Store store) async {
  String storeUid = '';
  try {
    await FirebaseFirestore.instance
        .collection('stores')
        .add(store.toJson())
        .then((value) => storeUid = value.id);
    return storeUid;
  } catch (e) {
    return 'failed';
  }
}


// final FirebaseAuth _auth = FirebaseAuth.instance;
// String? name;
// String? email;

// Future<String> signIn(String email, String password) async {
//   await Firebase.initializeApp();
//   try {
//     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     final User user = userCredential.user!;
//     final uid = user.uid;
//     return '$uid';
//     // return "Signed in";
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       return 'No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       return 'Wrong password provided for that user.';
//     }
//     return e.message!;
//   }
// }

// Future<String> signInEmail(String emailInput, String password) async {
//   await Firebase.initializeApp();
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: emailInput, password: password);

//     final User? user = userCredential.user;

//     if (user != null) {
//       assert(user.email != null);
//       name = null;
//       email = user.email;
//       assert(!user.isAnonymous);
//       assert(await user.getIdToken() != null);
//       final User currentUser = _auth.currentUser!;
//       assert(user.uid == currentUser.uid);
//       // print('signInWithGoogle succeeded: $user');
//       return '$user';
//     }
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       return 'Failed to sign in with Email & Password: No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       // print('Wrong password provided for that user.');
//       return 'Failed to sign in with Email & Password: Wrong password provided for that user.';
//     }
//   }
//   return 'Failed to sign in with Email & Password';
// }

// Future<String> signUpEmail(String emailInput, String password) async {
//   try {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: emailInput, password: password);
//     return 'done';
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       // print('The password provided is too weak.');
//       return 'weak';
//     } else if (e.code == 'email-already-in-use') {
//       // print('The account already exists for that email.');
//       return 'exists';
//     }
//   } catch (e) {
//     return 'error';
//   }
//   return 'error';
// }
