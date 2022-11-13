import 'package:flutter/material.dart';
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
                          subtitle: Text(controller.listCashier[index].email!),
                          leading: SizedBox(
                            height: double.infinity,
                            child: Icon(
                              (controller.listCashier[index].role == 'cashier')
                                  ? Icons.verified_user
                                  : Icons.pending_actions,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                          trailing: SizedBox(
                            height: double.infinity,
                            child: Icon(
                              (controller.listCashier[index].role == 'cashier')
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
    );
  }
}
