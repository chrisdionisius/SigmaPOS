import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/setting/category/category_controller.dart';
import 'package:sigma_pos/app/modules/setting/product/list_product_page.dart';
import 'package:sigma_pos/app/widget/bottom_navbar.dart';

import '../../../widget/category_dialog.dart';
import '../../../widget/modal_textfield.dart';

class ListCategoryPage extends StatelessWidget {
  const ListCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Obx(
            () => (controller.listCategory.isNotEmpty)
                ? ListView.builder(
                    itemCount: controller.listCategory.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(
                              ListProductPage(
                                  category: controller.listCategory[index]),
                            );
                          },
                          title: Center(
                            child: Text(controller.listCategory[index].name!),
                          ),
                          // subtitle: Text(controller.listCategory[index].description!),
                        ),
                      );
                    },
                  )
                : const Text('No Data'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CategoryDialog(controller: controller);
            },
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: const UserBottomNavbar(choosenIndex: 3),
    );
  }
}
