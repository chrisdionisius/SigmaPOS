import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/data/states/order_state.dart';
import 'package:sigma_pos/app/modules/order/order_controller.dart';
import 'package:sigma_pos/app/widget/custom_divider.dart';
import 'package:sigma_pos/app/widget/modal_textfield.dart';
import 'package:sigma_pos/app/widget/payment_notification_dialog.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({Key? key, required this.controller}) : super(key: key);
  final OrderController controller;

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
          Container(
            padding: const EdgeInsets.only(top: 10, right: 10),
            alignment: Alignment.topRight,
            child: InkWell(
              child: const Icon(Icons.close, size: 30),
              onTap: () => Get.back(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Nama Customer',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ModalTextField(
                  controller: controller.nameController,
                  hint: 'Nama customer',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bayar',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ModalTextField(
                  controller: controller.paymentController,
                  prefix: const Text(
                    'Rp ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  hint: '0',
                ),
                const SizedBox(height: 20),
                const CustomDivider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      'Rp ${controller.formatter.format(OrderState.total.value)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.isValid()) {
                Get.back();
                Get.dialog(PaymentNotificationDialog(controller: controller));
              } else {
                Get.snackbar("Error", "Please fill all the field");
              }
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
                'BAYAR',
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
