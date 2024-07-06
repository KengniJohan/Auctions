import 'package:auctions/controllers/account_controller.dart';
import 'package:auctions/services/remote/account_service.dart';
import 'package:get/get.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountService());
    Get.put(AccountController());
  }
}
