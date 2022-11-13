import 'package:get/get.dart';
import '../models/account.dart';

class AccountState {
  static Rx<Account> account = Account().obs;
}
