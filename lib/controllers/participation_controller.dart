import 'package:auctions/models/participation.dart';
import 'package:auctions/services/remote/participation_remote_service.dart';
import 'package:get/get.dart';

class ParticipationController extends GetxController {
  static final ParticipationController instance = Get.find();
  final ParticipationRemoteService _service = Get.find();

  Future<Participation?> insert(Participation participation) =>
      _service.insert(participation);

  Stream<List<Participation>> getAllAsStream() => _service.getAllAsStream();

  Future<List<Participation>> getAll() => _service.getAll();
}
