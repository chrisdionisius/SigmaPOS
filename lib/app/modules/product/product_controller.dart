import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sigma_pos/app/data/models/category.dart';

import '../../data/models/product.dart';
import '../../data/models/store.dart';
import '../../data/services/firestore_service.dart';
import '../../data/states/order_state.dart';

class ProductController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Category> listCategory = <Category>[].obs;
  RxInt selectedCategory = 0.obs;

  final formatter = NumberFormat("#,##0", "en_US");

  ProductController() {
    fetchProducts();
  }

  void fetchProducts() async {
    Store store = await readStore();
    listCategory.value = await readCategoriesAndProducts(store.id!);
    // await readStore();
    // final String dummyData =
    //     await rootBundle.loadString('assets/json/store.json');
    // Store store = Store.fromJson(jsonDecode(dummyData), 'aa');
    // listCategory.value = store.categories!;
  }

  Future<bool> fetchStore() async {
    Store store = await readStore();
    if (store.id == null) {
      return false;
    }
    listCategory.value = await readCategoriesAndProducts(store.id!);
    return true;
  }

  void addProduct(Product product) {
    OrderState.addProduct(product);
  }

  void removeProduct(Product product) {
    OrderState.removeProduct(product);
  }
}
