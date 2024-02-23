import 'package:get/get.dart';

class MerchantCart extends GetxController {
  var showButton = false.obs;
  var merchantFood = 1.obs;

  void toggleButton(bool value) {
    showButton.value = value;
  }

  void incrementFood() {
    merchantFood.value++;
  }

  void decrementFood() {
    if (merchantFood.value > 1) {
      merchantFood.value--;
    }
  }
}
