import 'package:auctions/models/proposition.dart';
import 'package:auctions/services/remote/proposition_remote_service.dart';
import 'package:get/get.dart';

class PropositionController extends GetxController {
  static final PropositionController instance = Get.find();
  final PropositionRemoteService _service = Get.find();

  Future<Proposition?> insert(Proposition propostion) =>
      _service.insert(propostion);

  Future<void> updateProposition(String id, Proposition proposition) =>
      _service.update(id, proposition);

  Stream<List<Proposition>> getAllAsStream() => _service.getAllAsStream();

  Future<List<Proposition>> getAll() => _service.getAll();
}
