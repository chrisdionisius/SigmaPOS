import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigma_pos/app/widget/bottom_navbar.dart';
import 'package:sigma_pos/app/widget/custom_divider.dart';

import '../../data/models/order.dart';
import '../../data/models/product.dart';

class SalesReportDetail extends StatelessWidget {
  const SalesReportDetail({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0", "en_US");
    final formatterDate = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formatterDateRead = DateFormat('dd MMMM yyyy - HH:mm:ss');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        title: Center(
          child: Text(
            order.id!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
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
        actions: const [
          Icon(
            Icons.shopping_cart,
            color: Color.fromRGBO(250, 250, 250, 1),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.id!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(order.customer!),
            const SizedBox(height: 5),
            Text(
              formatterDateRead.format(
                formatterDate.parse(order.date!),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                for (Product product in order.products!)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text(product.name!)),
                      Text('@${product.amount!}'),
                      Expanded(
                        child: Text(
                          'Rp ${formatter.format(product.price! * product.amount!)}',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 20),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp ${formatter.format(order.total!)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Print'),
        icon: const Icon(Icons.print),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: const UserBottomNavbar(
        choosenIndex: 2,
      ),
    );
  }
}
