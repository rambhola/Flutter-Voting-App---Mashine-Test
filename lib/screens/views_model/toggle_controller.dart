import 'package:get/get.dart';

class ToggleController extends GetxController {
  var isToggled = false.obs;

  //Methods to flip state

  void toggleSwitch(bool newValue) {
    isToggled.value = newValue;
  }
}
