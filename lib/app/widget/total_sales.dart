import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/sales_report/sales_report_controller.dart';

class TotalSales extends StatelessWidget {
  const TotalSales({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SalesReportController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Sales',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Obx(
            () => Text(
              'Rp ${controller.formatter.format(controller.totalSales.value)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
