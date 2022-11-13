import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sigma_pos/app/data/models/category.dart';
import 'package:sigma_pos/app/data/models/product.dart';

import '../../../data/services/firestore_service.dart';

class ManageProductController extends GetxController {
  RxList<Product> listProduct = <Product>[].obs;
  Rx<Category> category = Category().obs;
  final formatter = NumberFormat("#,##0", "en_US");

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  ManageProductController(Category cat) {
    category.value = cat;
    listProduct.value = cat.products!;
  }

  void fetchCategory() async {
    category.value = await readCategory(category.value.id!);
    // print(category.value.products!);
    listProduct.value = category.value.products!;
  }

  Future<bool> createProduct() async {
    if (nameController.text == "" || priceController.text == "") {
      Get.snackbar('Warning', 'Please fill all the field');
      return false;
    }
    if (listProduct
        .where((element) =>
            element.name!.toLowerCase() == nameController.text.toLowerCase())
        .isNotEmpty) {
      Get.snackbar('Warning', 'Product already exist');
      return false;
    }

    Product product = Product(
      name: nameController.text,
      price: int.parse(priceController.text),
    );

    if (await addProduct(product, category.value.id!)) {
      fetchCategory();
      nameController.text = "";
      priceController.text = "";
      return true;
    }
    return false;
  }
}
