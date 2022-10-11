import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/order/order_page.dart';
import 'package:sigma_pos/app/modules/product/product_page.dart';
import 'package:sigma_pos/app/modules/sales_report/sales_report_page.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            switch (value) {
              case 0:
                Get.to(() => const ProductPage());
                break;
              case 1:
                Get.to(() => const OrderPage());
                break;
              case 2:
                Get.to(() => const SalesReportPage());
                break;
              default:
                Get.to(() => const ProductPage());
            }
          },
          iconSize: 30,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: 'Produk'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timelapse_sharp), label: 'Order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on), label: 'Sales'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ],
          backgroundColor: Colors.white,
          fixedColor: Colors.black,
        ),
      ),
    );
  }
}
