import 'package:auctions/controllers/account_controller.dart';
import 'package:auctions/services/remote/account_remote_service.dart';
import 'package:get/get.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountRemoveService());
    Get.put(AccountController());
  }
}
