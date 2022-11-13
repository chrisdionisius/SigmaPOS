import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/order/order_page.dart';
import 'package:sigma_pos/app/modules/product/product_page.dart';
import 'package:sigma_pos/app/modules/sales_report/sales_report_page.dart';
import 'package:sigma_pos/app/modules/setting/setting_page.dart';

class UserBottomNavbar extends StatelessWidget {
  const UserBottomNavbar({Key? key, required this.choosenIndex})
      : super(key: key);
  final int choosenIndex;

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
          currentIndex: choosenIndex,
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
              case 3:
                Get.to(() => const SettingPage());
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
                icon: Icon(Icons.watch_later), label: 'Order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Sales'),
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
