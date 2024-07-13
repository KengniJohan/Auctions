import 'package:auctions/controllers/proposition_controller.dart';
import 'package:auctions/services/remote/proposition_remote_service.dart';
import 'package:get/get.dart';

class PropositionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PropositionRemoteService());
    Get.put(PropositionController());
  }
}
