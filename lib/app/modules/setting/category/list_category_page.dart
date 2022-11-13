import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/setting/category/category_controller.dart';

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
                          onTap: () {},
                          title: Center(
                              child:
                                  Text(controller.listCategory[index].name!)),

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
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
                child: Container(
                  margin: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Category Name',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            ModalTextField(
                              controller: controller.nameController,
                              hint: 'Category',
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 1),
                                child: InkWell(
                                  onTap: () {
                                    controller.nameController.text = "";
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    margin: EdgeInsets.zero,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 1),
                                child: InkWell(
                                  onTap: () async {
                                    if (await controller.createCategory()) {
                                      Get.back();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    margin: EdgeInsets.zero,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
