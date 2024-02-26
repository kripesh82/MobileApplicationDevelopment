import 'package:get/get.dart';

class PaymentViewModel extends GetxController {
  bool _addCard = false;
  bool _cardAdded = false;

  bool get addCard => _addCard;
  bool get cardAdded => _cardAdded;

  toggelAddCrad() {
    _addCard = !_addCard;
    update();
  }

  toggelCradAdded() {
    _cardAdded = !_cardAdded;
    update();
  }
}
