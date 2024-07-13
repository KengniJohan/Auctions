import 'package:auctions/models/auction.dart';
import 'package:auctions/services/remote/auction_remote_service.dart';
import 'package:get/get.dart';

class AuctionController extends GetxController {
  static final AuctionController instance = Get.find();
  final AuctionRemoteService _service = Get.find();

  Future<Auction?> insert(Auction auction) => _service.insert(auction);

  Future<void> updateAuction(String id, Auction auction) =>
      _service.update(id, auction);

  Stream<List<Auction>> getAllAsStream() => _service.getAllAsStream();

  Future<List<Auction>> getAll() => _service.getAll();
}
