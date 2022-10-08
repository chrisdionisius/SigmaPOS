import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sigma_pos/app/data/models/category.dart';

import '../../data/models/store.dart';

class ProductController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Category> listCategory = <Category>[].obs;
  RxInt selectedCategory = 0.obs;

  final formatter = NumberFormat("#,##0", "en_US");

  ProductController() {
    fetchProducts();
  }

  void fetchProducts() async {
    final String dummyData =
        await rootBundle.loadString('assets/json/store.json');
    Store store = Store.fromJson(jsonDecode(dummyData));
    listCategory.value = store.categories!;
  }
}
