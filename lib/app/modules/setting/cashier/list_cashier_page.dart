import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sigma_pos/app/modules/setting/cashier/cashier_controller.dart';
import '../../../widget/account_dialog.dart';

class ListCashierPage extends StatelessWidget {
  const ListCashierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CashierController controller = Get.put(CashierController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          title: const Text(
            'Cashiers',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.sort,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Obx(
              () => (controller.listCashier.isNotEmpty)
                  ? ListView.builder(
                      itemCount: controller.listCashier.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AccountDialog(
                                    controller: controller,
                                    account: controller.listCashier[index],
                                  );
                                },
                              );
                            },
                            title: Text(controller.listCashier[index].name!),
                            subtitle:
                                Text(controller.listCashier[index].email!),
                            leading: SizedBox(
                              height: double.infinity,
                              child: Icon(
                                (controller.listCashier[index].role ==
                                        'cashier')
                                    ? Icons.verified_user
                                    : Icons.pending_actions,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                            trailing: SizedBox(
                              height: double.infinity,
                              child: Icon(
                                (controller.listCashier[index].role ==
                                        'cashier')
                                    ? Icons.block
                                    : Icons.check_circle,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Empty'),
                    ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.store.value.registerCode!,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: (() async {
                                await Clipboard.setData(
                                  ClipboardData(
                                      text:
                                          controller.store.value.registerCode!),
                                );
                              }),
                              icon: const Icon(Icons.copy),
                            ),
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
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    margin: EdgeInsets.zero,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'Exit',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          label: const Text('Register Code'),
          icon: const Icon(Icons.copy),
          backgroundColor: Colors.black,
        ));
  }
}
