import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/order.dart';
import '../../data/services/firestore_service.dart';

class SalesReportController extends GetxController {
  RxList<Order> listOrders = <Order>[].obs;
  final formatter = NumberFormat("#,##0", "en_US");
  TextEditingController searchController = TextEditingController();
  List<String> listFilter = [
    'Today',
    'This Week',
    'This Month',
    'All',
  ];
  RxString selectedFilter = 'Today'.obs;
  RxInt totalSales = 0.obs;

  SalesReportController() {
    fetchSalesReport();
  }

  void fetchSalesReport() async {
    listOrders.value = await getOrders();
    totalSales.value = listOrders.fold(
        0, (previousValue, element) => previousValue + element.total!);
    // final String dummyData =
    //     await rootBundle.loadString('assets/json/sales.json');
    // listOrders.value = (json.decode(dummyData) as List)
    //     .map((e) => Order.fromJson(e, '3dfs'))
    //     .toList();
    // totalSales.value = listOrders
    //     .map((e) => e.total)
    //     .reduce((value, element) => value! + element!)!;
  }
}
