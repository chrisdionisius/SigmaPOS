import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/category.dart';

import '../../../data/models/store.dart';
import '../../../data/services/firestore_service.dart';

class CategoryController extends GetxController {
  RxList<Category> listCategory = <Category>[].obs;
  final TextEditingController nameController = TextEditingController();

  CategoryController() {
    fetchCategory();
  }

  void fetchCategory() async {
    Store store = await readStore();
    listCategory.value = await readCategoriesAndProducts(store.id!);
  }

  Future<bool> createCategory() async {
    if (nameController.text == "") {
      Get.snackbar('Warning', 'Please insert category name');
      return false;
    }
    if (listCategory
        .where((element) =>
            element.name!.toLowerCase() == nameController.text.toLowerCase())
        .isNotEmpty) {
      Get.snackbar('Warning', 'Category name already exist');
      return false;
    }
    if (await addCategory(nameController.text)) {
      fetchCategory();
      nameController.text = "";
      return true;
    }
    return false;
  }
}
