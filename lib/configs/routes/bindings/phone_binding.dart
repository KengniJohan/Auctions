import 'package:auctions/controllers/phone_controller.dart';
import 'package:auctions/services/remote/phone_remote_service.dart';
import 'package:get/get.dart';

class PhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PhoneRemoteService());
    Get.put(PhoneController());
  }
}
