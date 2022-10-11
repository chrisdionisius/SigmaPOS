import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/sales_report/sales_report_controller.dart';

class FilterTab extends StatelessWidget {
  const FilterTab({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final SalesReportController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () =>
            controller.selectedFilter.value = controller.listFilter[index],
        child: Obx(
          (() => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: controller.selectedFilter.value ==
                          controller.listFilter[index]
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    controller.listFilter[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: controller.selectedFilter.value ==
                              controller.listFilter[index]
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
