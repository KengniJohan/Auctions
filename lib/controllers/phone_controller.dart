import 'package:auctions/models/phone.dart';
import 'package:auctions/services/remote/phone_remote_service.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController {
  static final PhoneController instance = Get.find();
  final PhoneRemoteService _service = Get.find();

  Future<Phone?> insert(Phone phone) => _service.insert(phone);

  Future<void> updatePhone(String id, Phone data) => _service.update(id, data);

  Stream<List<Phone>> getAllAsStream() => _service.getAllAsStream();

  Future<List<Phone>> getAll() => _service.getAll();

  Future<Phone?> getById(String id) => _service.getById(id);
}
