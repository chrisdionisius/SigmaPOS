import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/category.dart';
import 'package:sigma_pos/app/modules/setting/product/manage_product_controller.dart';
import 'package:sigma_pos/app/widget/bottom_navbar.dart';

import '../../../widget/modal_textfield.dart';

class ListProductPage extends StatelessWidget {
  const ListProductPage({Key? key, required this.category}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    ManageProductController controller = Get.put(
      ManageProductController(category),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        title: Text(
          category.name!,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
        ],
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
            () => (controller.listProduct.isNotEmpty)
                ? ListView.builder(
                    itemCount: controller.listProduct.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(controller.listProduct[index].name!),
                          subtitle: Text(
                            controller.formatter.format(
                              controller.listProduct[index].price!,
                            ),
                          ),
                          trailing: SizedBox(
                            width: width / 3.8,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                                const VerticalDivider(
                                  width: 10,
                                  thickness: 1,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
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
                              'Product Name',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            ModalTextField(
                              controller: controller.nameController,
                              hint: 'Product Name',
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Price',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            ModalTextField(
                              controller: controller.priceController,
                              prefix: const Text(
                                'Rp ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              hint: '0',
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
                                    bool result =
                                        await controller.createProduct();
                                    if (result) {
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
        label: const Text('Add Product'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: const UserBottomNavbar(choosenIndex: 3),
    );
  }
}
