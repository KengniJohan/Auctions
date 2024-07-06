import 'package:auctions/models/user.dart';
import 'package:auctions/services/remote/user_service.dart';
import 'package:crypt/crypt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static final UserController instance = Get.find();
  final UserService _service = Get.find();

  Future<User?> insert(User user) {
    if (user.password != null) {
      final crypt = Crypt.sha256(user.password!);
      user.password = crypt.toString();
    }

    return _service.insert(user);
  }
}
