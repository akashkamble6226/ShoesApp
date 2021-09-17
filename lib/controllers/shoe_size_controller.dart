import 'package:get/get.dart';

class ShoeSizeController extends GetxController {
  var shoeSize = ["36", "37", "38", "39", "40", "41"];
  var isActive = [false, true, false, false, false, false];

  void toggleSelectSize(int index) {
    isActive[index] = true;

    for (var a = 0; a < 6; a++) {
      if (a != index) {
        isActive[a] = false;
      }
    }
    update();
  }

  
}
