import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/account.dart';
import '../modules/setting/cashier/cashier_controller.dart';
import 'custom_divider.dart';

class AccountDialog extends StatelessWidget {
  const AccountDialog({
    Key? key,
    required this.controller,
    required this.account,
  }) : super(key: key);
  final Account account;
  final CashierController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    account.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    account.email!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  const CustomDivider(
                    height: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    (account.role == 'cashier')
                        ? 'Deactivate Cashier ?'
                        : 'Activate Cashier ?',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 1),
                      child: InkWell(
                        onTap: () {
                          if (account.role == 'recruit') {
                            controller.rejectAccount(
                              account,
                            );
                          }
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'No',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 1),
                      child: InkWell(
                        onTap: () async {
                          bool result = await controller.changeAccountRole(
                            account,
                          );
                          if (result) {
                            Get.back();
                          } else {
                            Get.snackbar('Failed', 'Error while updating data');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
