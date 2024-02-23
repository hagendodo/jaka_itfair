import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxBool isCashPayment = false.obs;
  RxBool isCashlessPayment = false.obs;

  void checkCash(bool value) {
    if (value && !isCashPayment.value) {
      isCashPayment.value = true;
      isCashlessPayment.value = false;
    } else {
      isCashPayment.value = false;
    }
  }

  void checkCashless(bool value) {
    if (value && !isCashlessPayment.value) {
      isCashPayment.value = false;
      isCashlessPayment.value = true;
    } else {
      isCashlessPayment.value = false;
    }
  }
}
