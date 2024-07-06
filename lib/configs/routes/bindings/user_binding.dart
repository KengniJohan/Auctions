import 'package:auctions/controllers/user_controller.dart';
import 'package:auctions/services/local/user_local_service.dart';
import 'package:auctions/services/remote/user_remote_service.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRemoteService());
    Get.put(UserLocalService());
    Get.put(UserController());
  }
}
