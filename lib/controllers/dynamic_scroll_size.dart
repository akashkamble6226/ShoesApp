import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicScrollSize extends GetxController {
  double height = 600;


  
  late ScrollController scrollController;

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    
    super.onInit();
  }

  

  _scrollListener()
  {
    if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
          height = 600;
          print(height);
          update();
          
        } else {
          // You're at the bottom.

          height = 700;
           update();
         
        }
  }



}
}