import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicShoeSize extends GetxController {
  
 
  var widthArray = [300.0, 250.0, 200.0, 150.0];
 double width = 0.0;
  void changeWidth() {
    
    for (int i = 0; i < 4; i++) {
      width = widthArray[i];
      
     
    }

    update();
  }
}
