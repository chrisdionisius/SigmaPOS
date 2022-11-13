import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/states/order_state.dart';
import 'package:sigma_pos/app/modules/order/order_controller.dart';
import 'package:sigma_pos/app/widget/bottom_navbar.dart';
import 'package:sigma_pos/app/widget/main_button.dart';
import 'package:sigma_pos/app/widget/payment_dialog.dart';

import '../../widget/custom_divider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    OrderController controller = Get.put(OrderController());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        title: const Center(
          child: Text(
            'Order',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
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
              SizedBox(
                height: height * 3 / 5,
                child: Obx(
                  () => (OrderState.order.isNotEmpty)
                      ? ListView.builder(
                          itemCount: OrderState.order.length,
                          itemBuilder: (context, index) {
                            final product = OrderState.order[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: height / 5,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 30, top: 20),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Rp ${controller.formatter.format(product.price!)}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 30, bottom: 20),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors
                                                          .white, // Button color
                                                      child: InkWell(
                                                        onTap: () {
                                                          controller
                                                              .removeProduct(
                                                                  product);
                                                        },
                                                        child: const SizedBox(
                                                          width: 25,
                                                          height: 25,
                                                          child: Icon(
                                                              Icons.remove),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Text(
                                                      product.amount.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  ClipOval(
                                                    child: Material(
                                                      color: Colors
                                                          .white, // Button color
                                                      child: InkWell(
                                                        onTap: () {
                                                          controller.addProduct(
                                                              product);
                                                        },
                                                        child: const SizedBox(
                                                          width: 25,
                                                          height: 25,
                                                          child:
                                                              Icon(Icons.add),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                'Rp ${controller.formatter.format(product.amount! * product.price!)}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // const Spacer(),
                                  Container(
                                    height: height / 5,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('Empty Order'),
                        ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Discount',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Icon(Icons.add_circle, color: Colors.black),
                ],
              ),
              const SizedBox(height: 5),
              const CustomDivider(
                height: 1,
                color: Colors.black,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => Text(
                      'Rp ${controller.formatter.format(OrderState.total.value)}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MainButton(
                label: 'BAYAR',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PaymentDialog(controller: controller);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const UserBottomNavbar(
        choosenIndex: 1,
      ),
    );
  }
}
