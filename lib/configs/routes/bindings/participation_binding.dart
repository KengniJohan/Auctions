import 'package:auctions/controllers/participation_controller.dart';
import 'package:auctions/services/remote/participation_remote_service.dart';
import 'package:get/get.dart';

class ParticipationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ParticipationRemoteService());
    Get.put(ParticipationController());
  }
}
