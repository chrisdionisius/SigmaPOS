import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sigma_pos/app/data/models/product.dart';
import 'package:sigma_pos/app/data/services/firestore_service.dart';

import '../../data/models/order.dart';
import '../../data/states/order_state.dart';

class OrderController extends GetxController {
  // RxObjectMixin<Order> order = Order().obs;
  // RxList<Product> listProduct = <Product>[].obs;
  final formatter = NumberFormat("#,##0", "en_US");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  int change = 0;

  Order order = Order();

  OrderController() {
    // fetchOrder();
  }

  // void fetchOrder() async {
  //   final String dummyData =
  //       await rootBundle.loadString('assets/json/orders.json');
  //   Order order = Order.fromJson(jsonDecode(dummyData), '1');
  //   listProduct.value = order.products!;
  // }

  void addProduct(Product product) {
    OrderState.addProduct(product);
  }

  void removeProduct(Product product) {
    OrderState.removeProduct(product);
  }

  bool isValid() {
    if (nameController.text != "" && paymentController.text != "") {
      if (int.parse(paymentController.text) < OrderState.total.value) {
        Get.snackbar("Error", "Payment amount is not enough");
        return false;
      }
      change = int.parse(paymentController.text) - OrderState.total.value;
      return true;
    }
    return false;
  }

  void sendData() async {
    order.customer = nameController.text;
    order.products = OrderState.order;
    order.bayar = int.parse(paymentController.text);
    order.date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    order.time = DateFormat('HH:mm:ss').format(DateTime.now());
    order.discount = 0;
    order.total = OrderState.total.value;
    await sendOrder(order);
    OrderState.clearOrder();
  }
}
