import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/account.dart';

import '../../../data/models/store.dart';
import '../../../data/services/firestore_service.dart';

class CashierController extends GetxController {
  RxList<Account> listCashier = <Account>[].obs;
  Rx<Store> store = Store().obs;

  CashierController() {
    fetchStore();
    fetchCashier();
  }

  void fetchCashier() async {
    listCashier.value = await fetchStoreCashier();
  }

  void fetchStore() async {
    store.value = await readStore();
  }

  Future<bool> changeAccountRole(Account account) async {
    if (account.role == 'cashier') {
      account.role = 'recruit';
    } else {
      account.role = 'cashier';
    }
    fetchCashier();
    return await updateAccountRole(account.id!, account.role!);
  }

  Future<bool> rejectAccount(Account account) async {
    return await updateAccountRole(account.id!, 'rejected');
  }
}
