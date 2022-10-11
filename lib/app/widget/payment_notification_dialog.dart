import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/product/product_page.dart';

import 'custom_divider.dart';

class PaymentNotificationDialog extends StatelessWidget {
  const PaymentNotificationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(context) {
    return Container(
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Total',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    Text(
                      'Rp 60.000',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Bayar',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    Text(
                      'Rp 100.000',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const CustomDivider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Kembali',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      'Rp 40.000',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.offAll(
                const ProductPage(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.zero,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Text(
                'TUTUP',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
