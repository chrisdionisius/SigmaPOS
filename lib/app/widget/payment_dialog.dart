import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/widget/custom_divider.dart';
import 'package:sigma_pos/app/widget/modal_textfield.dart';
import 'package:sigma_pos/app/widget/payment_notification_dialog.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({Key? key}) : super(key: key);

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
                const ModalTextField(
                  hint: 'Nama customer',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bayar',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const ModalTextField(
                  prefix: Text(
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
                  children: const [
                    Text(
                      'Total',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      'Rp 0',
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
              Get.back();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const PaymentNotificationDialog();
                },
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
