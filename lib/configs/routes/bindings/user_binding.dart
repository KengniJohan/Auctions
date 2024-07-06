import 'package:auctions/controllers/user_controller.dart';
import 'package:auctions/services/remote/user_service.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
    Get.put(UserController());
  }
}
