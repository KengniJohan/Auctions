import 'package:get/get.dart';

class OngletController extends GetxController {
  static final OngletController instance = Get.find();
  int index = 0;

  void updateIndex(int index) {
    this.index = index;
    update();
  }
}
