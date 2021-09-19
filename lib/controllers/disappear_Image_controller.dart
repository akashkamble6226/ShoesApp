import 'package:get/get.dart';

class DisappearImageController extends GetxController
{
   double makeVisible = 1.0 ;
  //  RxDouble makeDisappear = 0.0.obs;

   void makeImageDisappear()
  {
    makeVisible = 0.0;
    update();
  }
}