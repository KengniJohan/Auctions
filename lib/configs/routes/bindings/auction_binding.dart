import 'package:auctions/controllers/auction_controller.dart';
import 'package:auctions/services/remote/auction_remote_service.dart';
import 'package:get/get.dart';

class AuctionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuctionRemoteService());
    Get.put(AuctionController());
  }
}
