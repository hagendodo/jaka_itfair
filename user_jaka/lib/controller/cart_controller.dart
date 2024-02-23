import 'package:get/get.dart';

class ShowCartController extends GetxController {
  RxInt count = 1.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }
}

class CartFoodController extends GetxController {
  RxInt count = 1.obs;
  RxBool isCheckbox = false.obs;

  void checkBox(bool value) {
    isCheckbox.value = !isCheckbox.value;
  }

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }
}
