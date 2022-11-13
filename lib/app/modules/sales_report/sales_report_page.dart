import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/sales_report/sales_report_controller.dart';
import 'package:sigma_pos/app/widget/bottom_navbar.dart';

import '../../widget/filter_tab.dart';
import '../../widget/sales_card.dart';
import '../../widget/search_textfield.dart';
import '../../widget/total_sales.dart';

class SalesReportPage extends StatelessWidget {
  const SalesReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SalesReportController controller = Get.put(SalesReportController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        title: const Center(
          child: Text(
            'Sales',
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
        actions: const [
          Icon(
            Icons.shopping_cart,
            color: Color.fromRGBO(250, 250, 250, 1),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.listFilter.length,
                itemBuilder: (context, index) {
                  return FilterTab(controller: controller, index: index);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TotalSales(controller: controller),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: height / 1.8,
              child: Obx(
                () => (controller.listOrders.isNotEmpty)
                    ? ListView.builder(
                        itemCount: controller.listOrders.length,
                        itemBuilder: (context, index) {
                          final order = controller.listOrders[index];
                          return SalesCard(
                            order: order,
                            controller: controller,
                          );
                        },
                      )
                    : const Center(
                        child: Text('No Data'),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const UserBottomNavbar(
        choosenIndex: 2,
      ),
    );
  }
}
