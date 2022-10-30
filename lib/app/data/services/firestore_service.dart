import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigma_pos/app/data/models/order.dart';
import 'package:sigma_pos/app/data/states/register_state.dart';

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

Future<String> signUpWithEmail(email, password) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await addUser(result.user!.uid);
    return 'success';
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

Future<Store> readStore() async {
  try {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('stores')
        .where('user_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.docs.first);
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

Future<String> checkAvailableEmail(String email) async {
  try {
    List<String> userAvail =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (userAvail.isEmpty) {
      return 'success';
    } else {
      return 'not available';
    }
  } catch (e) {
    return 'failed';
  }
}

Future<String> checkRegisterCode(String code) async {
  try {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('stores')
        .where('register_code', isEqualTo: code)
        .get()
        .then((value) => value.docs.first);
    if (documentSnapshot.exists) {
      RegisterState.store.value = Store.fromJson(
          jsonDecode(jsonEncode(documentSnapshot.data())), documentSnapshot.id);
      return 'success';
    } else {
      return 'failed';
    }
  } catch (e) {
    return 'failed';
  }
}

Future<String> addUser(String uid) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'role': 'recruit',
      'store_id': RegisterState.store.value.id,
    });
    return 'success';
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
