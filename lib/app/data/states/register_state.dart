import 'package:get/get.dart';
import 'package:sigma_pos/app/data/models/store.dart';

class RegisterState {
  static RxString email = ''.obs;
  static RxString password = ''.obs;

  static Rx<Store> store = Store().obs;
}
