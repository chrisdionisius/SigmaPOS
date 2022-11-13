import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/states/order_state.dart';
import 'package:sigma_pos/app/modules/order/order_page.dart';
import 'package:sigma_pos/app/widget/bottom_navbar.dart';
import 'package:sigma_pos/app/widget/search_textfield.dart';
import 'package:sigma_pos/app/widget/total_order_button.dart';

import '../../widget/drawer.dart';
import 'product_controller.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    ProductController controller = Get.put(ProductController());
    return Scaffold(
      drawer: DrawerWidget(height: height, width: width),
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ListView(
            children: [
              SearchTextField(
                controller: controller.searchController,
                hint: 'Search',
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width / 2,
                height: height / 20,
                child: Obx(
                  () => (controller.listCategory.isNotEmpty)
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.listCategory.length,
                          itemBuilder: (context, index) {
                            final category = controller.listCategory[index];
                            return Center(
                              child: InkWell(
                                onTap: () {
                                  controller.selectedCategory.value = index;
                                  debugPrint(
                                    controller.selectedCategory.value
                                        .toString(),
                                  );
                                },
                                child: Obx(
                                  () => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    margin: const EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      color:
                                          (controller.selectedCategory.value ==
                                                  index)
                                              ? Colors.black
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      category.name!,
                                      style: TextStyle(
                                          color: (controller
                                                      .selectedCategory.value ==
                                                  index)
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              height: height * 3 / 10,
                              width: height * 3 / 10,
                              child: const Text('Category is empty'),
                            );
                          },
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 16 / 30,
                child: Obx(
                  () => (controller.listCategory.isNotEmpty &&
                          controller
                              .listCategory[controller.selectedCategory.value]
                              .products!
                              .isNotEmpty)
                      ? ListView.builder(
                          itemCount: controller
                              .listCategory[controller.selectedCategory.value]
                              .products!
                              .length,
                          itemBuilder: (context, index) {
                            final product = controller
                                .listCategory[controller.selectedCategory.value]
                                .products![index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              height: height / 10,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.name!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Rp ${controller.formatter.format(product.price!)}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            (OrderState.order.contains(product))
                                                ? Colors.black
                                                : const Color.fromRGBO(
                                                    217, 217, 217, 1),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            (OrderState.order.contains(product))
                                                ? ClipOval(
                                                    child: Material(
                                                      color: Colors
                                                          .white, // Button color
                                                      child: InkWell(
                                                        onTap: () => controller
                                                            .removeProduct(
                                                                product),
                                                        child: const SizedBox(
                                                          width: 25,
                                                          height: 25,
                                                          child: Icon(
                                                              Icons.remove),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 25,
                                                  ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Obx(
                                                () => Text(
                                                  (OrderState.order
                                                          .contains(product))
                                                      ? OrderState.order
                                                          .where((element) =>
                                                              element.id ==
                                                              product.id)
                                                          .first
                                                          .amount
                                                          .toString()
                                                      : '0',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            ClipOval(
                                              child: Material(
                                                color: Colors
                                                    .white, // Button color
                                                child: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .addProduct(product);
                                                  },
                                                  child: const SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'No Product',
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
              Obx(
                () => TotalOrderButton(
                  label: 'TOTAL',
                  total: OrderState.total.value,
                  onPressed: () => Get.to(
                    () => const OrderPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const UserBottomNavbar(
        choosenIndex: 0,
      ),
    );
  }
}
