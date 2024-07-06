import 'package:auctions/models/user.dart';
import 'package:auctions/services/local/user_local_service.dart';
import 'package:auctions/services/remote/user_remote_service.dart';
import 'package:crypt/crypt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static final UserController instance = Get.find();
  final UserRemoteService _remoteService = Get.find();
  final UserLocalService _localService = Get.find();

  Future<User?> insert(User user) {
    if (user.password != null) {
      final crypt = Crypt.sha256(user.password!);
      user.password = crypt.toString();
    }

    return _remoteService.insert(user);
  }

  Future<User?> signIn(String email, String password) async {
    final foundUser = (await findByEmail(email)).firstOrNull;
    if (foundUser == null || foundUser.password == null) {
      return null;
    }

    if (!Crypt(foundUser.password!).match(password)) {
      return null;
    }

    _login(foundUser);

    return foundUser;
  }

  Future<List<User>> findByEmail(String email) =>
      _remoteService.findByEmail(email);

  Future<bool> _login(User user) => _localService.login(user);

  Future<User?> getLoggedUser() => _localService.getLoggedUser();

  Future<bool> logout() => _localService.logout();
}
