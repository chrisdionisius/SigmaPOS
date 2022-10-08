import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sigma_pos/app/data/models/order.dart';
import 'package:sigma_pos/app/data/models/product.dart';

class OrderController extends GetxController {
  // RxObjectMixin<Order> order = Order().obs;
  RxList<Product> listProduct = <Product>[].obs;
  final formatter = NumberFormat("#,##0", "en_US");

  OrderController() {
    fetchOrder();
  }

  void fetchOrder() async {
    final String dummyData =
        await rootBundle.loadString('assets/json/orders.json');
    Order order = Order.fromJson(jsonDecode(dummyData), '1');
    listProduct.value = order.products!;
  }
}
