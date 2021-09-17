import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeImageController extends GetxController {
  var isActive = [true, false, false, false];

  late ScrollController scrollController;

  _scrollListener() {
    // if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange)
    // {
    //   print("Reached the End");
    // }
    // if (scrollController.offset <= scrollController.position.minScrollExtent && !scrollController.position.outOfRange)
    // {
    //   print("Reached To Top");
    // }

    int index = (scrollController.offset / 350).round() + 1;

    toggleSwippedImage(index);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  void toggleSwippedImage(int index) {
    isActive[index - 1] = true;
    for (var a = 0; a < 4; a++) {
      if (a != index - 1) {
        isActive[a] = false;
      }
    }
    update();
  }
}
