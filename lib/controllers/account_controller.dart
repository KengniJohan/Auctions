import 'package:auctions/models/account.dart';
import 'package:auctions/services/remote/account_remote_service.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  static final AccountController instance = Get.find();
  final AccountRemoveService _service = Get.find();

  Future<Account?> insert(Account account) {
    account.amount = 10000;
    return _service.insert(account);
  }
}
