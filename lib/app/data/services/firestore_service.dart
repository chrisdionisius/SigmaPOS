import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigma_pos/app/data/models/account.dart';
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

Future getCurrentAccount() async {
  try {
    var user = await getCurrentUser();
    var account = await FirebaseFirestore.instance
        .collection('accounts')
        .doc(user!.uid)
        .get();
    return Account.fromJson(account.data()!, account.id);
  } catch (e) {
    return e;
  }
}

Future<String> getAccountStore() async {
  try {
    final user = await getCurrentUser();
    final store = await FirebaseFirestore.instance
        .collection('accounts')
        .doc(user!.uid)
        .get();
    return store.data()!['store_uid'];
  } catch (e) {
    return 'failed';
  }
}

Future<Store> readStore() async {
  try {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('stores')
        .doc(await getAccountStore())
        .get();
    return Store.fromJson(
        jsonDecode(jsonEncode(documentSnapshot.data())), documentSnapshot.id);
  } catch (e) {
    return Store();
  }
}

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

Future<Category> readCategory(String categoryId) async {
  try {
    final Store store = await readStore();
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('stores/${store.id}/categories')
        .doc(categoryId)
        .get();
    List<Product> productsList = [];
    Query productsQuery = FirebaseFirestore.instance
        .collection("stores/${store.id}/categories/$categoryId/products")
        .orderBy('name');
    QuerySnapshot productsQuerySnapshot = await productsQuery.get();
    for (var productDocument in productsQuerySnapshot.docs) {
      productsList.add(
        Product.fromJson(
            jsonDecode(jsonEncode(productDocument.data())), productDocument.id),
      );
    }
    Category category =
        Category.fromJson(documentSnapshot.data()!, documentSnapshot.id);
    category.products = productsList;
    return category;
  } catch (e) {
    return Category();
  }
}

Future<void> sendOrder(Order order) async {
  //get store id
  final Store store = await readStore();
  //send order
  await FirebaseFirestore.instance
      .collection('stores/${store.id}/orders')
      .add(order.toJson());
}

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

Future<bool> addAccount(String userUid, Account account, String email) async {
  try {
    await FirebaseFirestore.instance.collection('accounts').doc(userUid).set({
      'name': account.name,
      'role': account.role,
      'store_uid': account.storeUid,
      'email': email,
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

Future<List<Account>> fetchStoreCashier() async {
  try {
    final Store store = await readStore();
    var accountsQuerySnapshot = await FirebaseFirestore.instance
        .collection('accounts')
        .where('store_uid', isEqualTo: store.id)
        .where('role', isNotEqualTo: 'owner')
        .orderBy('role')
        .get();
    List<Account> accountsList = [];
    for (var document in accountsQuerySnapshot.docs) {
      accountsList.add(
        Account.fromJson(document.data(), document.id),
      );
    }
    return accountsList;
  } catch (e) {
    return [];
  }
}

Future<bool> updateAccountRole(String accountUid, String role) async {
  try {
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(accountUid)
        .update({'role': role});
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> addCategory(String name) async {
  try {
    final Store store = await readStore();
    await FirebaseFirestore.instance
        .collection('stores/${store.id}/categories')
        .add({'name': name});
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> addProduct(Product product, String categoryId) async {
  try {
    final Store store = await readStore();
    await FirebaseFirestore.instance
        .collection('stores/${store.id}/categories/$categoryId/products')
        .add(product.toJson());
    return true;
  } catch (e) {
    return false;
  }
}
