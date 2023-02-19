import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/menu.dart';
import 'package:sigma_pos/app/data/states/account_state.dart';

class SettingController extends GetxController {
  final List<Menu> ownerMenu = [
    Menu(
      name: 'Cashier',
      icon: 0xf401,
      route: '/listCashier',
    ),
    Menu(
      name: 'Product',
      icon: 0xe60b,
      route: '/listCategory',
    ),
    Menu(
      name: 'Edit Profile',
      icon: 0xe491,
      route: '/cashFlow',
    ),
    Menu(
      name: 'Logout',
      icon: 0xe3b3,
      route: '/pengaturan',
    ),
  ];
  final List<Menu> cashierMenu = [
    Menu(
      name: 'Edit Profil',
      icon: 0xf401,
      route: '/pemasukan',
    ),
    Menu(
      name: 'Logout',
      icon: 0xf401,
      route: '/pengeluaran',
    ),
  ];
  List<Menu> listMenu = [];

  SettingController() {
    if (AccountState.account.value.role == 'owner') {
      listMenu = ownerMenu;
    } else {
      listMenu = cashierMenu;
    }
  }
}
